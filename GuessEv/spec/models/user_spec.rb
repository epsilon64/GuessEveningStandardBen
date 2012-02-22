require 'spec_helper'

describe User do

	it "should delete all user's title when unsuscribe" do

		user = User.new :email => 'toto@tutu.fr', :password => 'azerty', :password_confirmation => 'azerty'
    	user.skip_confirmation!
    	user.save!
    	user.titles.create :name => "Premier des titres"

    	user.destroy
    	Title.all.should be_empty

	end

end
