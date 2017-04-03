class Task < ActiveRecord::Base
  attr_accessible :title
  has_many :users, through: :user_tasks
  has_many :user_tasks
end
