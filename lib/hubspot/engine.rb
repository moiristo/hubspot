module Hubspot
  
  class Engine < Rails::Engine
    
    config.hubspot_site         = 'demo.app11.hubspot.com'
    config.hubspot_access_token = 'demooooo-oooo-oooo-oooo-oooooooooooo'
    config.hubspot_key          = 'demo'
    config.hubspot_portal_id    = '62515'
    config.debug_http_output    = STDOUT
    
    ActiveSupport.on_load(:action_controller) do      
      include Hubspot::ActionControllerExtensions
    end
    
  end

  def self.config; Hubspot::Engine.config; end    
  
end