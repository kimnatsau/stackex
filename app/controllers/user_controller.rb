class UserController < ApplicationController
	def index
		
		
	end
	def create
		if User.find_by(name: params[:name])
			
		end
		@user=User.new
		get_user
		if @user.save

			
		end
		
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
            @user.stack_id=(user_data['items'][0]["account_id"])
            @user.name=(user_data['items'][0]["display_name"])
           end    
      else      
    end
		
	end
	def get_qustion

		
	end
end
