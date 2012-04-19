ActiveAdmin.register User do

	filter :email
	filter :last_sign_in_at
	filter :created_at

	scope :standard
	scope :super
  
  	index do
		column :id
		column :email do |user|
			link_to "#{user.email}", admin_user_path(user)
		end
		column "titles" do |user|
			user.titles.count
		end
		column :type
	end


	show :title => :email do
		panel "current headline" do
			if user.hasCurrentTitle?
				attributes_table_for user.titles.last do
					row("name") { |title| link_to "#{title.name}", admin_title_path(title) }
					row :created_at
				end
			else
				"no current headline"
			end
		end
	end

end
