class TitlesController < ApplicationController

layout 'main'

def index
	p = SuperUser.first
	#Instanciate object for creation
	@title = Title.new

	#Gets the 5 last super user headlines
	@title_historic = p.titles.last(5)

	#Gets the 10 twitter trend
	@tweet_trends = Title.getTwitterTrends

	if user_signed_in?
		p = current_user.getTodayUserTitle
		if p.empty?
			@today_title = nil
		else
			@today_title = p.first.name
		end
	else
		@today_title = nil
	end
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

def edit
	@title = Title.new

	p = current_user.getTodayUserTitle
	@today_title = p.first.name
end

def update
	p = current_user.getTodayUserTitle
	p.first.name = params[:title][:name]
	p.first.save!
	redirect_to '/users/todaytitle'
end

end
