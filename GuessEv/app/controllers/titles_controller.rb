class TitlesController < ApplicationController

def index
	@title = Title.new
end

def create
	@user = current_user
	@title = @user.titles.build(:name => params[:title][:name])
	unless @user.save
		render 'index'
	return
	end 
	flash[:notice] = "Title created"
	redirect_to :back
end
end
