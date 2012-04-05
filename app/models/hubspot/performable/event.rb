require 'uri'  
require 'net/http'
    
module Hubspot
  module Performable
  
    # The Event class can be used to record events using the Performable API.
    # Example: Hubspot::Event.new('event_32145').record!
    # The response will always be a 1X1 transparent GIF, this is because the HTTP API can be used via an HTML image tag as well :)
    class Event < Struct.new(:event_id, :performed_at, :completed_at, :url, :ip, :value, :order_id, :custom_parameters)
      include ActiveModel::Validations
    
      validates :event_id, :presence => true
      
      # _a - Your Performable API key. (Your API Key can be found in Account Settings within your Performable account.)
      # _n - The EVENT_ID of the event you want to record. You can get an event id in two ways:
      # Log into your Performable account, click Setup, and then click on the event that you wish to record. Finally, click the configuration link to bring up a dialog which shows you the event id.
      # Use your own unique label as the id, and Performable will automatically generate the corresponding event in your account. You can rename it from within the app later if you'd like.
      # There are also optional parameters:
      # 
      # _t - The timestamp of the event (in seconds as a UTC Unix epoch). By default this is ignored - it is used only to help make requests unique and the time that our servers receive the event is used for the timestamp of the event.
      # _d - If equal to the string true, implies that the timestamp sent with this event should be used as the time of completion for this event. The timestamp will be ignored if it represents a future date (within some reason), or is more than a few years old. Servers generating timestamps should use some mechanism (like NTP) for syncing clocks to a reasonable standard. The API expects timestamps are in seconds, but may detect timestamps in milliseconds and attempt to resolve them to seconds.
      # _l (that's a lowercase L) - The URL that triggered this event.
      # _ip - The IP address of the user who completed this event. This is useful if you want Performable to assign location data to a user based on their IP address.
      #
      # If you are recording an e-commerce transaction you may use any of the following parameters:
      # 
      # value - A monetary value associated with this event, such as the purchase amount or expected conversion value. This value should be a number with no formatting other than a period representing the decimal point (if necessary.)
      # order_id - A unique identifier associated with the order or transaction. This is used to make sure this transaction is not counted more than once.    
      PARAMETER_MAPPING = { :event_id => '_n', :performed_at => '_t', :completed_at => '_d', :url => '_l', :ip => '_ip', :value => 'value', :order_id => 'order_id'}

      def record!
        return false unless valid?
     
        uri.query = to_param      
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output(Hubspot.config.debug_http_output) if Hubspot.config.debug_http_output
            
        return http.request_get(uri.request_uri).code.to_i
      end
    
      # Records, but doesn't raise an error when the record fails and returns flase instead.
      def record
        record! rescue false
      end    
    
      # Sets the Performable API URI
      def uri
        @uri ||= URI('http://analytics.performable.com/v1/event')            
      end
    
      # Converts the event to encoded form data.
      def to_param
        parameters = PARAMETER_MAPPING.keys.inject({}) do |hash, parameter| 
          parameter_value = send(parameter)
          hash[PARAMETER_MAPPING[parameter]] = parameter_value if parameter_value.present?
          hash
        end

        parameters.merge!(custom_parameters) if custom_parameters
        parameters.merge!('_a' => Hubspot.config.hubspot_key)        
        parameters.to_param      
      end

    end
  end
end