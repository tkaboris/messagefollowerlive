class Speaker < ActiveRecord::Base
  has_many :messages, :dependent => :destroy
  has_many :messageparts, :dependent => :destroy
  has_many :listeners_speakers,  class_name: 'ListenersSpeakers'
  has_many :listeners, through: :listeners_speakers
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def fullname
  "#{self.name} #{self.lastname}"
  end


end
