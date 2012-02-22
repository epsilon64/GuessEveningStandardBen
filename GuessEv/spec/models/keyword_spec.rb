require 'spec_helper'

describe Keyword do

	it 'should split a Title into several Keywords' do
  		
  		user = User.new :email => 'toto@tutu.fr', :password => 'azerty', :password_confirmation => 'azerty'
    	user.skip_confirmation!
    	user.save!

    	user.titles.create :name => "Premier des titres"
    	user.save!

    	keywordList = user.titles.first.keywords.all

    	keywordList.length.should == 2
      keywordList.first.name.should == "Premier"
    	keywordList[1].name.should == "titres"

	end

  it 'should incrment existing keywords' do
    user = User.new :email => 'toto@tutu.fr', :password => 'azerty', :password_confirmation => 'azerty'
    user.skip_confirmation!
    user.save!
    user.titles.create :name => "Premier des titres"
    keywordList = user.titles.first.keywords.all

    keywordList.first.count.should == 1
    keywordList[1].count.should == 1


    user2 = User.new :email => 'tata@tutu.fr', :password => 'azerty', :password_confirmation => 'azerty'
    user2.skip_confirmation!
    user2.save!
    user2.titles.create :name => "Premier des trucs"
    
    Keyword.all.length.should == 3
    Keyword.find_by_name("Premier").count.should == 2
    Keyword.find_by_name("titres").count.should == 1
    Keyword.find_by_name("trucs").count.should == 1
  end



end