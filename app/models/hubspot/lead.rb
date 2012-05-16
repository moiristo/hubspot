module Hubspot
  
  # Finds and updates leads
  #
  # Finds:
  # Hubspot::Lead.find :all, :params => { :search => 'test' }
  # Hubspot::Lead.find <GUID>  
  #
  # Updates:
  # lead.firstName = 'Reinier'; lead.save!
  # lead.update_attributes(:firstName => 'Reinier')
  class Lead < Hubspot::Base
    self.site = 'https://api.hubapi.com/leads/v1'
    
    schema do
      string 'guid', 'salutation', 'firstName', 'lastName', 'email', 'website', 'company'
      string 'address', 'state', 'city', 'zip', 'country'
      string 'phone', 'fax', 'userToken', 'industry', 'jobTitle', 'twitterHandle', 'ipAddress'
      float  'score'
    end
    
    alias_attribute :id, :guid

    # Override the create, as it differs totally from the other calls.
    class << self
      def create attributes
        create!(attributes) rescue false
      end
            
      def create! attributes
        return Hubspot::Lead.connection.post("http://#{ Hubspot.config.hubspot_site }/?app=leaddirector&FormName=#{attributes.delete(:FormName)}", attributes.to_query, { 'Content-Type' => 'application/x-www-form-urlencoded', 'skip_default_parameters' => '1' })
      end   
    end
    
  end
  
end