module Hubspot
  module ActionControllerExtensions
    extend ActiveSupport::Concern
    
    included do
      helper_method :hubspot_user_token
    end
    
    # Returns the user token (GUID). This can be used to check whether the current user has been recorded as a Lead.
    def hubspot_user_token
      @hubspot_user_token ||= cookies[:hubspotutk]
    end
    
  end
end