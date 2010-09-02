require 'digest'
class User < ActiveRecord::Base

	attr_accessor :password
	#Only password, and password_confirmation attributes can be changed with params hash
	attr_accessible :password, :password_confirmation
	#Name validations
    validates_presence_of :name
	validates_length_of :name, :maximum => 30
	validates_each :name do |record, attr, value|
	    record.errors.add(attr, 
		    " must consist of only alphanumeric characters(including underline)") if value =~ /\W/
	end
	#Email validations
    validates_length_of :email, :maximum => 50
	validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,4}$/, 
	    :message => "Email address is not accepted or is invalid"
    validates_confirmation_of :email, :message => "Email confirmation does not match"
	#IP validations
	validates_length_of :ip, :maximum => 30
	validates_format_of :ip, :with => 
	    /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
	#Password validations
	validates_presence_of :password
	validates_length_of :password, :maximum => 30
	validates_confirmation_of :password, :message => "Password confirmation does not match"
	#Encrypting the password before it is saved to the database
	before_save :encrypt_password
	#Relationship between user and computer
	has_many :computers, :foreign_key => "user_id", :autosave => true, :dependent => :destroy
	
	def has_password? (submitted_password)
	    self.encrypted_password == encrypt(submitted_password)
	end
		
	private
	
	    def encrypt_password
		    self.salt = make_salt(self.password)
			self.encrypted_password = encrypt(self.password)
		end
		
		def encrypt(string)
			Digest::SHA2.hexdigest("#{self.salt}#{string}")
		end
		
		def make_salt(string)
			Digest::SHA2.hexdigest("#{Time.now.utc}#{string}")
		end
end