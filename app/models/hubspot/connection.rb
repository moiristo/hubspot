module Hubspot

  class Connection < ActiveResource::Connection
    
    # Set default parameters to send along with each request
    def self.default_parameters
      @default_parameters ||= { 'access_token' => Hubspot.config.hubspot_access_token, 'portalId' => Hubspot.config.hubspot_portal_id }
    end
    
    # Override to support debug output
    def configure_http(http)
      http.set_debug_output(Hubspot.config.debug_http_output) if Hubspot.config.debug_http_output
      super
    end 
  
  private
  
    # Makes a request to the remote service and appends the default parameters
    def request(method, path, *arguments)  
      uri = URI.parse(path)

      Hubspot::Connection.default_parameters.to_param.tap do |default_parameters|
        if uri.query.present?
          uri.query += '&' + default_parameters
        else
          uri.query = default_parameters
        end
      end
      
      super(method, uri.to_s, *arguments)
    end
       
  end

end