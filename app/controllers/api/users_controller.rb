module Api
class UsersController < ApiController

  before_filter :authenticate_user

  def login
    if params[:name].blank? or params[:device_id].blank?
      render :json => {
        'error' => 'MISSING_PARAMS'
      },
      :status => 400
    else
      user = User.where(:device_id => params[:device_id]).first_or_create
      user.name = params[:name]
      user.credits=100
      user.save
      response = {}
      response['status'] = "SUCCESS"
      response['user'] = {
        'id' => user.id,
        'name' => user.email,
        'credits' => user.credits,
        'device_id' => user.device_id
      }
      render :json => response,
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
      # user = User.where(:device_id => params[:device_id]).first

      @user.credits += 50
      @user.save
      render :json => {
        'status' => 'SUCCESS'
      },
      :status => 200
    end
  end

    def refresh
      #do book keeping operations here

      #update status of events
      Event.where("open_till < ?",Time.zone.now).update_all(:status => 'CLOSED')
      Event.where("open_till > ?",Time.zone.now).update_all(:status => 'OPEN')

      ##update odds


      ##send notification of event result
      
      

      render :json => HelperModel.get_response(@user) , :status => 200

    end
end
end