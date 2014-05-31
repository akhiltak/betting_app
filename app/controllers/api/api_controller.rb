module Api
class ApiController < ApplicationController
  
  private
  def authenticate_user
    if params[:device_id].blank?
      render :json => {
        'error' => "You need to login first!"
      },
      :status => 401
      return
    else
      @user = User.where(:device_id => params[:device_id]).first_or_create
    end
  end



end
end