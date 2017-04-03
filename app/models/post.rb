class Post < ActiveRecord::Base
  attr_accessible :body, :published_at, :title
  belongs_to :user, counter_cache: true
  has_many :pictures, :as => :imageable, dependent: :destroy
  
  validates :user_id, presence: true

  scope :published, -> { where(created_at: true) }
  # default_scope order: 'posts.created_at DESC'
end
