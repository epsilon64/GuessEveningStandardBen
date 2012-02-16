class User < ActiveRecord::Base
  
  has_many :titles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
 
def getTodayUserTitle
	#GuessEv::Application.RESTART_TIME_HOUR
	if DateTime.now.hour > 18
		dateEndInterval = DateTime.civil(DateTime.now.year, DateTime.now.month, DateTime.now.day+1, 18 , 0, 0, Rational(0, 24))
	else
		dateEndInterval = DateTime.civil(DateTime.now.year, DateTime.now.month, DateTime.now.day, 18 , 0, 0, Rational(0, 24))
	end

	return self.titles.where(:created_at => dateEndInterval-1.day..dateEndInterval)
end


end

class SuperUser < User

end