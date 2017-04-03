class Image < ActiveRecord::Base
  attr_accessible :url
  belongs_to :imageable, :polymorphic => true, dependent: :destroy

  validates :user_id, presence: true
end
