module Api
  class EventsController < ApiController

    before_filter :authenticate_user

    def index
      render :json => HelperModel.get_response(@user), :status => 200
    end
    #user_status will be "lost" or "win"
    def self.event_completion(action, device_id)
      user = User.where(:device_id => device_id).first rescue nil
      if user.nil?
        return
      end

      if action == "EVENT_COMPLETED"
        data = {
          'title' => 'Betting App alert',
          'alert' => 'Result of an event updated'
        }

        ParseModel.push_notification('event_result_received', "user_" + device_id.to_s, data)
      end

      if action == "BET_PLACED"
        data = {
          'title' => 'Betting App alert',
          'alert' => 'Your bet has been placed'
        }

        ParseModel.push_notification('bet_placed', "user_" + device_id.to_s, data)
      end
    end

  end
end
