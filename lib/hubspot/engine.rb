module Hubspot
  
  class Engine < Rails::Engine
    
    # The domain of your Hubspot site, which is used in the javascript tracker code
    config.hubspot_site         = 'demo.app11.hubspot.com'
    
    # The access token for authenticating to several Hubspot services, e.g. 'demooooo-oooo-oooo-oooo-oooooooooooo'
    config.hubspot_access_token = nil
    
    # Your API key
    config.hubspot_key          = 'demo'
    
    # Your Portal ID
    config.hubspot_portal_id    = '62515'
    
    # Enables/disables logging of HTTP requests and response.
    # false - Disables debugging
    # STDOUT - logs to STDOUT. Of course you can specify any IO object you want.
    config.debug_http_output    = false # STDOUT
    
    ActiveSupport.on_load(:action_controller) do
      include Hubspot::ActionControllerExtensions
    end
    
  end

  def self.config; Hubspot::Engine.config; end    
  
end