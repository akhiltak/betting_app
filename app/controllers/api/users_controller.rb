module Api
class UsersController < ApiController

  def login
    if params[:name].blank? or params[:device_id].blank?
      render :json => {
        'error' => 'MISSING_PARAMS'
      },
      :status => 400
    else
      user = User.where(:device_id => params[:device_id]).first_or_create
      user.name = params[:name]
      user.save
      render :json => {
        'status' => 'SUCCESS'
      },
      :status => 200
    end
  end

end
end