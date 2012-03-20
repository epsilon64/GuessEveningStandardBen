require 'rubygems'   # Need this to make use of any Gem, in our case it is rufus-scheduler
require 'rufus/scheduler'  # Need this to make use of Rufus::Scheduler
require 'title'
require 'user'

# OPTION 1: If you want to run the scheduler as part of your very own rails process then you may adopt this option

scheduler = Rufus::Scheduler.start_new
# Making use of the syntax used in Crontab

scheduler.cron '0 19 * * *' do

	#SuperUser get the today's headline
	p = SuperUser.first
	answer = p.getTodayUserTitle
	if answer.empty?
		title_of_the_day = Title.getESTitle
		p.titles.create :name => title_of_the_day
	end
end



# #OPTION 2: If for whatever reason (say, for performance reasons) you want to run your rake tasks as seperate process independent of your rails application, then you may adopt this option


# temp_files_cleaning_scheduler = Rufus::Scheduler.start_new  
# #Making use of a more intutive approach, instead of Cron syntax

# temp_files_cleaning_scheduler.every "1m" do  
#     # Programmatically, kick-starting the rake task from the command line

#    system "rake tempfile:delete_all RAILS_ENV=#{RAILS.env}"  

