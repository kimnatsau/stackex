class UsersController < ApplicationController
	def index
		@user=User.new
		
	end
	def new
		@user=User.new
	end
	def create
		
		# if @user=User.find_by(name: user_params[:name])
		# 	get_tags
		# 	render :text => @user
		# else
			@user=User.new

			get_user
				if @user.save
					get_tags
					
				else
					render :text => "no"			
				end
		# end
		

		
	end
	private
	def user_params
		params.require(:user).permit(:name)
	end

	def get_user
		name=user_params["name"]
      $URL_id = "https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=#{name}&site=stackoverflow"
      response = Net::HTTP.get_response(URI.parse($URL_id))
      user_data=JSON.parse(response.body)
      if user_data['items'][0] 
      if user_data['items'][0]["display_name"]==name
            @user.stack_id=(user_data['items'][0]["user_id"])
            @user.name=(user_data['items'][0]["display_name"])
            #render :text => user_data

           end    
      else 

    end
		
end
	def get_tags
		$URL_id = "https://api.stackexchange.com/2.2/users/#{@user.stack_id}/top-tags?site=stackoverflow"
      	response = Net::HTTP.get_response(URI.parse($URL_id))
      	tag_data=JSON.parse(response.body)
      	if tag_data['items'][0]
      		#render :text => "Okqq"
      		get_question(tag_data['items'][0]["tag_name"])
      	else
      		render :text => tag_data
      	end


		
	end
	def get_question(tag)
		
		$URL_id = "https://api.stackexchange.com/2.2/tags/#{tag}/faq?site=stackoverflow"
      	response = Net::HTTP.get_response(URI.parse($URL_id))
      	tag_data=JSON.parse(response.body)
      	render :text => tag_data
      	# render layout: "question"
		
	end
end
