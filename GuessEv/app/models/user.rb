class User < ActiveRecord::Base
  
has_many :titles

after_destroy :deleteTitles

# Include default devise modules. Others available are:
# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable

# Setup accessible (or protected) attributes for your model
attr_accessible :email, :password, :password_confirmation, :remember_me

	def getTodayUserTitle
		dateEndInterval = User.dateEndInterval
		return self.titles.where(:created_at => dateEndInterval-1.day..dateEndInterval)
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

end

