class UsersController < ApplicationController
  
def todaytitle
	p = current_user.getTodayUserTitle
	@today_title = p.first.name
end



def showpreviousheadlines
	@previous_headlines = current_user.titles.last(5).reverse
end

end