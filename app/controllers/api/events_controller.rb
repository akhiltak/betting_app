module Api
class EventsController < ApiController

  before_filter :authenticate_user

  def index
    render :json => HelperModel.get_response(@user), :status => 200
  end
#user_status will be "lost" or "win"
  def self.event_completion(action, device_id, event_id = nil, bet_id=nil, user_status)
    user = User.where(:device_id => device_id).first resue nil
    if user.nil?
      return
    end

    if action == "EVENT_COMPLETED"
      data = {
        :name => user.name,
        :device_id => device_id.to_s,
        :event_name => Event.find(event_id.to_i).name,
        :user_status => user_status,
        :credits => Bet.find(bet_id.to_i).bet_amount
      }
      
    ParseModel.push_notification('event_result_received', "user_" + device_id.to_s, data)
  end
end

end
end