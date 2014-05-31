module Api
class EventsController < ApiController

  before_filter :authenticate_user

  def index
    events = Event.all
    render :json => {
      'events' => events
    },
    :status => 200
  end


end
end