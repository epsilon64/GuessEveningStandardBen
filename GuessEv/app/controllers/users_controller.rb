class UsersController < ApplicationController
  
def todaytitle
	p = current_user.getTodayUserTitle
	@today_title = p.first.name
end

end