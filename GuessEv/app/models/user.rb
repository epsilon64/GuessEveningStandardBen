class User < ActiveRecord::Base
  
has_many :titles

after_destroy :deleteTitles

scope :standard, where(:type => 'User')
scope :super, where(:type => 'SuperUser')

# Include default devise modules. Others available are:
# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable 
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

# Setup accessible (or protected) attributes for your model
attr_accessible :email, :password, :password_confirmation, :remember_me

	def getTodayUserTitle
		dateEndInterval = User.dateEndInterval
		return self.titles.where(:created_at => dateEndInterval-1.day..dateEndInterval)
	end

	def hasCurrentTitle?
		if self.getTodayUserTitle.nil?
			return false
		else 
			return true
		end
	end

	def deleteTitles
		p = self.getTodayUserTitle
		if !p.empty?
			p.first.keywords.each do |k|
				k.count = k.count - 1
			end
		end
		self.titles.destroy_all
	end

	def self.dateEndInterval
		#GuessEv::Application.RESTART_TIME_HOUR
		if DateTime.now.hour > 18
			dateEndInterval = DateTime.civil(DateTime.now.year, DateTime.now.month, DateTime.now.day+1, 18 , 0, 0, Rational(0, 24))
		else
			dateEndInterval = DateTime.civil(DateTime.now.year, DateTime.now.month, DateTime.now.day, 18 , 0, 0, Rational(0, 24))
		end
		return dateEndInterval
	end

	def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
	  data = access_token.extra.raw_info
	  if user = User.where(:email => data.email).first
	    user
	  else # Create a user with a stub password. 
	    User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
	  end
	end

	def self.find_for_open_id(access_token, signed_in_resource=nil)
	  data = access_token.info
	  if user = User.where(:email => data["email"]).first
	    user
	  else
	    User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
	  end
	end
end

