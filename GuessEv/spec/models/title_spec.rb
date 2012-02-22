require 'spec_helper'
require 'ruby-debug'

describe Title do

  it "shouldn't save a title without user associated" do
  	title = Title.new :name => "Un titre"
  	expect {user.save!}.to raise_error
  end

	it "shouldn't save several user's titles on a same day" do
    user = User.new :email => 'toto@tutu.fr', :password => 'azerty', :password_confirmation => 'azerty'
    user.skip_confirmation!
    user.save!

    user.titles.build :name => "Premier titre"
    user.save!
    user.titles.build :name => "Second titre"
    expect {user.save!}.to raise_error
	end

  it "should get twitter trends" do

    trends = Title.getTwitterTrends
    trends.length.should == 10


  end



end
