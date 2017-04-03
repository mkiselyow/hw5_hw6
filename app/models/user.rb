class User < ActiveRecord::Base
  # (название скоупа и лямба в квадратн скобках)
  after_save :say_bye
  before_create :say_hi
  before_destroy :die

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.username = username.downcase }

  attr_accessible :first_name, :last_name, :email, :username, :password, :birthday
 
  default_scope -> { where(active: true) }
  scope :active, -> { where(active: true) }
  scope :with_email, -> { where('email IS NOT NULL') }

  # scope :older_18years, -> { where("Time.now.to_date.year - :birthday.year >= ?", 18) }
  # scope :older_18years, -> { where ( ":birthday.year >= ?" 1800) }
  # scope :older_18years, -> { where('birthday <= ?', Time.now.to_date - 18 years) }
  # scope :last_week, lambda { where("birthday <= ?", Time.zone.18yearsago. ) }
  scope :older_18years, lambda { where("birthday <= ?", Time.zone.now - 18*365*24*60*60 ) }
 
  has_one :profile
  has_many :comments
  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  has_many :posts, dependent: :destroy
  has_many :pictures, :as => :imageable
  

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 8 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  	uniqueness: { case_sensitive: false }


  	def full_name
  		p "#{self.first_name}" + " #{self.last_name}"
  	end

  	def self.to_csv
  		attributes = %w{id first_name last_name username email password birthday}
  		CSV.generate(headers: true) do |csv|
  			csv << attributes 
  			all.each do |user|
  				csv << user.attributes.values_at(*attributes)
  			end
  			#column_names
  			#all.each do |user|
  			#	csv << user.attributes.values_at(*column_names)
  			#end
  		end
  	end

  	def self.import(file)
  		CSV.foreach(file.path, headers: true) do |row|
  			user = find_by_id(row["id"]) || new
  			user.attributes = row.to_hash.slice(*accessible_atributes)
  			user.save!
  		end
  	end


    private
  
   def say_hi
     puts '------- HELLO -------'
   end
 
   def say_bye
     puts '------- GOODBYE -------'
   end
 
   def die
     puts '------- I\'LL BE BACK -------'
   end
   

end
 

