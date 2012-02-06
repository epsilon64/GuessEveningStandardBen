require 'spec_helper'

describe Keyword do

	pending 'should split a Title into several Keywords' do
  		
  		@user = User.new :email => 'toto@tutu.fr', :password => 'azerty', :password_confirmation => 'azerty'
    	@user.skip_confirmation!
    	@user.save!

    	@user.titles.create :name => "Premier des titres"
    	@user.save!

    	keywordList = @user.titles.first.keywords.all

    	keywordList.first.name.should include "Premier"
    	keywordList[2].name.should include "titres"

	end


end
