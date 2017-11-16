class SessionsController < ApplicationController
  # method to log in and start session
  
  
  def create

	  @user = User.find_by_email(params[:email].downcase)
	  if @user 
      if @user.authenticate(params[:password])
        @user.regenerate_auth_token
	       render :json => @user.json_hash
      else 
        render status: :unauthorized, :json => {
          :password => ["Incorrect Password"]
        }
      end
	  else
      render status: :unauthorized, :json => {
        :email => ["Incorrect Email"]
      }
	  end
	end
end