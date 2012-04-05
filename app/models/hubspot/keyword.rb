module Hubspot
  
  # Finds and updates leads
  #
  # Finds:
  # Hubspot::Keyword.find :all
  # Hubspot::Keyword.find <GUID>  
  #
  # Creates:
  # Hubspot::Keyword.create({ :keyword => { :keyword => 'sleutel' }})
  # Note that you should pass in the root element 'keyword', as activeresource removes the root element name when it matches the object name
  class Keyword < Hubspot::Base
    self.site = 'https://api.hubapi.com/keywords/v1'
    
    schema do
      string 'keyword'
    end
    
    alias_attribute :id, :keyword_guid
    
    class << self
      def instantiate_collection(collection, prefix_options = {})
        collection = collection['keywords'] if collection.is_a?(Hash)
        collection.collect! { |record| instantiate_record(record, prefix_options) }
      end
              
      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end        
    end
    
    protected
    
    # Override to support the object returned after create
    def load_attributes_from_response(response)
      if (response_code_allows_body?(response.code) &&
          (response['Content-Length'].nil? || response['Content-Length'] != "0") &&
          !response.body.nil? && response.body.strip.size > 0)
          
        response_data = self.class.format.decode(response.body)
        load(response_data.is_a?(Array) ? response_data.first : response_data, true)
        @persisted = true
      end
    end    
  
  end
  
end