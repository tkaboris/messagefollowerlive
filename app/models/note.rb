class Note < ActiveRecord::Base
  belongs_to :notable, polymorphic: true
  belongs_to :listener
  validates :listener, :presence => true
  validates :notable, :presence => true
end
