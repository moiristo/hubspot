module Hubspot
  module ActionControllerExtensions
    extend ActiveSupport::Concern
    
    included do
      helper_method :hubspot_user_token
    end
    
    def hubspot_user_token
      @hubspot_user_token ||= cookies[:hubspotutk]
    end
    
  end
end