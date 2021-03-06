class Title < ActiveRecord::Base

has_and_belongs_to_many :keywords
belongs_to :user

require 'open-uri'
require 'json'
require 'nokogiri'

validates :name, :presence => true
validates :user_id, :presence => true
validate :duplicatePostsCheck

after_create :create_keywords


def duplicatePostsCheck
	todayTitlesOfUser = self.user.getTodayUserTitle

	unless todayTitlesOfUser.empty?
		if self.id == todayTitlesOfUser.first.id
			return
		else
			errors.add :name,  "User #{self.user_id} has already posted today"
		end
	end
end



#At Title creation
#Create splitted keywords from the new title
def create_keywords
	@title_to_parse = self.name
	keywordsArray = parseTitles @title_to_parse
	keywordsArray.each do |t|
		dateEndInterval = User.dateEndInterval
		keyw = Keyword.where(:created_at => dateEndInterval-1.day..dateEndInterval, :name => t)
		if !keyw.empty?
			keyw.first.increment(:count)
			keyw.first.save
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
	rssSrc = Nokogiri::HTML(open("http://standardonline.newspaperdirect.com/epaper/services/rss.ashx?cid=1237&type=full"))
	pRSS = rssSrc.xpath('//item/title')
	esTitle = pRSS.first.text
	#Parsed text is "DD/MM/YYYY: FRONT PAGE: TITLE IS HERE"
	#Need to get rid of the 24 first chars
	esTitle = esTitle.last(esTitle.length - 24)
end

def self.getTwitterTrends
	tweet_trends = []
	jsonSrc = JSON.parse(open("http://api.twitter.com/1/trends/44418.json").read)
	jsonSrc.first["trends"].each do |p|
		tweet_trends << p["name"]
	end
	return tweet_trends
end

def calculateRanking

	answer_keywords = SuperUser.first.getTodayUserTitle.first.id

end

end
