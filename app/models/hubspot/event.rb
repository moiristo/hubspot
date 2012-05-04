module Hubspot
  
  # Finds and updates events
  #
  # Finds:
  # Hubspot::Event.find :all, :params => { :max => 5 }
  #
  # Creates:
  # Hubspot::Event.create(:eventType => 'new event', :description => 'test', :url => 'http://dev.hubspot.com', :createDate => '1323272544000' )
  class Event < Hubspot::Base
    self.site = 'https://api.hubapi.com/events/v1'
    
    schema do
      string 'description', 'eventType', 'url', 'createDate'
    end
    
    class << self
      def create attributes
        create!(attributes) #rescue false
      end
            
      def create! attributes
        return Hubspot::Event.post('events', attributes).code.to_i
      end
      
      def custom_method_collection_url(method_name, options = {})
        prefix_options, query_options = split_options(options)
        "#{prefix(prefix_options)}#{method_name}#{query_string(query_options)}"
      end
      
      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end      
    end
  
  end
  
end