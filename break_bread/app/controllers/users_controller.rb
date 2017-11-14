class UsersController < ApplicationController
  before_action :require_token, only: [:validate]

  # method to validate a user
  def validate
    render :json => @current_user.json_hash
  end

  # method to create a new user
  def create

    @user = User.new(user_params)
    
    if @user.valid?
      @user.save()
      render :json =>  @user.json_hash
    else 
      puts @user.errors.messages.inspect()
      render status: :bad_request, :json => {
        :errors => @user.errors.messages
      }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
