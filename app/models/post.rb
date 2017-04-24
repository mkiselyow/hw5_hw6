class Post < ActiveRecord::Base
  attr_accessible :body, :published_at, :title
  belongs_to :user, counter_cache: true
  has_many :pictures, :as => :imageable
  
  validates :user_id, presence: true
  validates :title, :body, :presence => true, length: { maximum: 140 }
  # validates :title, :uniqueness => true
  validates :title, :length => { :minimum => 2 }

  scope :published, -> { where(created_at: true) }
  default_scope order: 'posts.created_at DESC'
  # default_scope order: 'posts.created_at DESC'
end

