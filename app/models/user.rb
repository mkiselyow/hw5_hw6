class User < ActiveRecord::Base
  # (название скоупа и лямба в квадратн скобках)
has_secure_password
# has_gravatar не работает
  # include Gravtastic не работает
  # gravtastic не работает

  after_save :say_bye
  before_create :say_hi
  before_destroy :die

  before_save { |user| user.email = email.downcase }
  # before_save { |user| user.username = username.downcase }

  attr_accessible :first_name, :last_name, :email, :username, :password_confirmation, :birthday, :password, :user_id
  # before_save :encrypt_password
 
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

  # def self.authenticate(email, password)
  #   user = find_by_email(email)
  #   if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  #     user
  #   else
  #     nil
  #   end
  # end

  # def encrypt_password
  #   if password.present?
  #     self.password_salt = BCrypt::Engine.generate_salt
  #     self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  #   end
  # end


  	def full_name
  		p "#{self.first_name}" + " #{self.last_name}"
  	end

  	def self.to_csv(options = {})
  		# attributes = %w{id first_name last_name username email password birthday}
  		CSV.generate(options) do |csv|
  			csv << attribute_names 
  			all.each do |user|
  				csv << user.attributes.values_at(*attribute_names)
  			end
  			#column_names
  			#all.each do |user|
  			#	csv << user.attributes.values_at(*column_names)
  			#end
  		end
  	end

  	def self.import(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
      # end
  		# CSV.foreach(file.path, headers: true) do |row|
        # User.create! row.to_hash
  			user = find_by_username(row["username"]) || new
  			user.attributes = row.to_hash.slice(*accessible_attributes)
  			user.save!
  		end
  	end

    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
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
 

