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
  
  end
  
end