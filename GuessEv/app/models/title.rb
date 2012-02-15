class Title < ActiveRecord::Base

validates :name, :presence => true
validates :user_id, :presence => true
validate :duplicatePostsCheck

after_create :create_keywords

def new
	
end

def duplicatePostsCheck
	todayTitlesOfUser = self.user.getTodayUserPost

	unless todayTitlesOfUser.empty?
		errors.add :name,  "User #{self.user_id} has already posted today"
	end
end



#At Title creation
#Create splitted keywords from the new title
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

#Parse a Title and split it in an array conataining words longer than 3
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

#Gets the Evening Standard latest Headline
def self.getESTitle
	require 'open-uri'
	rssSrc = Nokogiri::HTML(open("http://standardonline.newspaperdirect.com/epaper/services/rss.ashx?cid=1237&type=full"))
	pRSS = rssSrc.xpath('//item/title')
	esTitle = pRSS.first.text
	#Parsed text is "DD/MM/YYYY: FRONT PAGE: TITLE IS HERE"
	#Need to get rid of the 24 first chars
	esTitle = esTitle.last(esTitle.length - 24)
end

has_and_belongs_to_many :keywords
belongs_to :user

end
