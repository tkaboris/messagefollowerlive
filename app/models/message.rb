class Message < ActiveRecord::Base
  belongs_to :speaker
  has_many :message_categories
  has_many :categories, through: :message_categories
  has_many :messageparts, dependent: :destroy
  has_attached_file :image, styles: { large: "500x500", medium: "300x350#" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_presence_of :send_at
  validates_presence_of :title

  #returns the message which needs to be process today
  scope :todays_messages, -> { where("DATE(send_at) <= ? AND delivered_at IS ?", Date.today, nil) }

  #returns messages who have messageparts for sending email
  scope :messages_to_mail, -> { where("id IN (?) and delivered_at IS NOT ?", Messagepart.message_ids_having_un_delivered_messageparts, nil) }

  #this will give listeners for message object
  #ref: http://apidock.com/rails/Module/delegate
  delegate :listeners, to: :speaker

  validate do |message|
    if message.send_at_changed? && message.delivered_at.present?
      message.errors[:send_at] << "send_at can't be change, emails are already scheduled!"
    end
  end

  #class methods at one place
  class << self
    def send_messages_to_listeners
      Rails.logger.info "######send_messages_to_listeners START #{Time.now}"

      messages = Message.todays_messages

      messages.each do |message|
        Rails.logger.info "message : #{message.id}"

        message.listeners.each do |listener|

          next unless message.valid_listener?(listener)

          send_at = send_at_for(message.send_at, listener)
          SendMessageEmailWorker.perform_at(send_at, message.id, listener.id)
          Rails.logger.info "message : scheduling for :: message_id: #{message.id}, send_at:#{send_at}, listener_id: #{listener.id}, email #{listener.email}"
        end
        message.update_attributes(delivered_at: Time.now)
      end

      Rails.logger.info "######send_messages_to_listeners END #{Time.now}"
    end

    #get the date of sending email, by including listener's profile time(hour) and timezone
    def send_at_for send_at, listener
      offset = Time.now.in_time_zone(listener.time_zone).strftime("%:z") rescue "+00:00"
      DateTime.new(send_at.year, send_at.month, send_at.day, listener.recieve_message_at.to_i, 0, 0).change(:offset => offset).utc rescue send_at
    end
  end

  def valid_listener? listener
    ls = listener.listeners_speakers.where(speaker_id: speaker.id).first
    ls.created_at < created_at if ls
  end

  #default date for message is current date!
  def default_date
    Date.today
  end

  #default date for message_part should be next date of last message-part OR next date of message if there are no message-parts present.
  def message_part_default_date
    if messageparts.exists?
      messageparts.order(created_at: :desc).first.send_at + 1.day
    else
      send_at + 1.day
    end
  end

  #image url
  def attached_img
    image? ? image.url(:medium) : ''
  end

  def image?
    image.present?
  end

  def msg_part_no
    messageparts.count + 1
  end

  #to get the image path, used for image atachment in email.
  def get_image_path
    URI.join(ActionController::Base.asset_host, image.url(:large).split('?').first)
  end
end
