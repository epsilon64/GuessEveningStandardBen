class UsersController < ApplicationController
  
  	layout 'main'

	def todaytitle
		p = current_user.getTodayUserTitle
		@today_title = p.first.name
	end

	def showpreviousheadlines
		@previous_headlines = current_user.titles.last(5).reverse
	end

	def show
		begin
			@current_user ||= User.find(params[:id])
			@previous_headlines = current_user.titles.last(5).reverse
		rescue
			redirect_to "/", :flash => { :error => "User doesn't exist" }
		end
	end
end


