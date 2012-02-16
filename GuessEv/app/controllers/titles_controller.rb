class TitlesController < ApplicationController

require 'user'

def index
	@title = Title.new

	p = SuperUser.first

	answer = p.getTodayUserTitle
	if answer.empty?
		title_of_the_day = Title.getESTitle
		p.titles.create :name => title_of_the_day
	end

	@title_historic = p.titles.last(5)

	@tweet_trends = Title.getTwitterTrends

end

def create
	@user = current_user
	@title = @user.titles.build(:name => params[:title][:name])
	unless @user.save
		render 'index'
	return
	end 
	flash[:notice] = "Title created"
	redirect_to '/users/todaytitle'
end

end
