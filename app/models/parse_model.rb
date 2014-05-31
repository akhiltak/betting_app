
require 'json'
require 'parse-ruby-client'

#collapse_key
class ParseModel
  #data parameter is a hash that can be sent along with notification
  def self.push_notification(collapse_key, channels, data = nil, push_time = nil)
    Parse.init(:application_id  => 'FWcmH50VWJ4m5E41q2JwmwK0bgriJOcCQ3ycVmCo', :api_key => 'WfXM042XoB9NHL61I3PIrOX421c9wM7fdUvKVybe')
    message = { 
      :action => "com.hackathon.bettinggame.PARSE_NOTIFICATION",
      :collapse_key => collapse_key
    }
    unless data.nil?
      message = message.merge(data)
    end
    unless push_time.nil?
      message["push_time"] = push_time
    end
    push = Parse::Push.new(message)
    push.channels = channels.split(',').map{|channel| channel}
    push.type = "android"
    push.save
  end
end