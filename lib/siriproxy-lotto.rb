require 'cora'
require 'siri_objects'
require 'pp'
	
class SiriProxy::Plugin::Lotto < SiriProxy::Plugin

  def initialize(config)
    #if you have custom configuration options, process them here!
  end

  #get the user's location and display it in the logs
  #filters are still in their early stages. Their interface may be modified
  filter "SetRequestOrigin", direction: :from_iphone do |object|
    puts "[Info - User Location] lat: #{object["properties"]["latitude"]}, long: #{object["properties"]["longitude"]}"
    
    
    #Note about returns from filters:
    # - Return false to stop the object from being forwarded
    # - Return a Hash to substitute or update the object
    # - Return nil (or anything not a Hash or false) to have the object forwarded (along with any 
    #    modifications made to it)
  end 

  listen_for /Hi/i do
    say "สวัสดีค่ะ !"
    request_completed
  end

  listen_for /siri proxy test question/i do
    response = ask "Is this thing working?" #ask the user for something
    
    if(response =~ /yes/i) #process their response
      say "Great!" 
    else
      say "You could have just said 'yes'!"
    end
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
end