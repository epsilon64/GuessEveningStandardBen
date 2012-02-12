class TitleController < ApplicationController

def index
	@titles = Title.all
end

end
