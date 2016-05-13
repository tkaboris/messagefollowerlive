class MessageMailer < ActionMailer::Base
  default from: "meditate@messagefollower.com"

  def mail_message_to_listener(message, listener)
    @message = message
    @listener = listener
    if @message.image?
      message_image_path = @message.get_image_path
      attachments[@message.image_file_name] = File.read(message_image_path)
    end
      I18n.with_locale(@listener.locale) do
    mail(to: @listener.email, subject: "#{@message.title}, Part 1")
      end
    end

  def mail_message_part_to_listener(messagepart, listener)
    @messagepart = messagepart
    @listener = listener
    message_title = @messagepart.message.title
    part_number = @messagepart.part_no
    if @messagepart.image?
      message_part_image_path = @messagepart.get_image_path
      attachments[@messagepart.image_file_name] = File.read(message_part_image_path)
    end
      I18n.with_locale(@listener.locale) do
    mail(to: @listener.email, subject: "#{part_number.ordinalize} part of #{message_title}, Part #{part_number+1}")
      end
  end
end
# MessageMailer.mail_message_to_listener(Message.first, Listener.first)