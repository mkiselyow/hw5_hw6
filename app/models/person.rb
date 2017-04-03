class Person < ActiveRecord::Base
  attr_accessible :title, :body, :name
  validates :name, :presence => true
  validates :terms_of_service, :acceptance => true
end
