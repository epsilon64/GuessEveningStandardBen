class Title < ActiveRecord::Base

validates :name, :presence => true
validates :user_id, :presence => true
validate :duplicatePostsCheck

after_create :create_keywords

def duplicatePostsCheck
	user = self.user
	#GuessEv::Application.RESTART_TIME_HOUR
	if DateTime.now.hour > 18
		dateEndInterval = DateTime.civil(DateTime.now.year, DateTime.now.month, DateTime.now.day+1, 18 , 0, 0, Rational(0, 24))
	else
		dateEndInterval = DateTime.civil(DateTime.now.year, DateTime.now.month, DateTime.now.day, 18 , 0, 0, Rational(0, 24))
	end

	todayTitlesOfUser = user.titles.where(:created_at => dateEndInterval-1.day..dateEndInterval)

	unless todayTitlesOfUser.empty?
		errors.add :name,  "User #{self.user_id} has already posted today"
	end
end

def create_keywords

	@title_to_parse = self.name
	keywordsArray = parseTitles @title_to_parse

	keywordsArray.each do |t|

		if Keyword.find_by_name t
			keyw = Keyword.find_by_name t
			keyw.count += 1
			keyw.save
			self.keywords << keyw
			self.save
		else
			self.keywords.create :name => t, :count => 1
		end

	end

end

def parseTitles(titleToParse)

	splittedTitle = titleToParse.split

	res = []

	splittedTitle.each do |t|
		if t.size > 3
			res << t
		end
	end
	return res
end


has_and_belongs_to_many :keywords
belongs_to :user

end
