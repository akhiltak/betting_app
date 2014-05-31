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

  def update_credits
    if params[:device_id].blank?
            render :json => {
        'error' => 'MISSING_PARAMS'
      },
      :status => 400
    else
      #check if last accessed time 
      user = User.where(:device_id => params[:device_id]).first
      user.credits += 50
      user.save
      render :json => {
        'status' => 'SUCCESS'
      },
      :status => 200
    end
  end

    def refresh

      #do book keeping operations here

    end
end
end