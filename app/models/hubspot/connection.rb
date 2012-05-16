module Hubspot

  class Connection < ActiveResource::Connection
    
    # Set default parameters to send along with each request
    def self.default_parameters
      @default_parameters ||= begin
        default_parameter_hash = {}
        default_parameter_hash['portalId'] = Hubspot.config.hubspot_portal_id
        
        if Hubspot.config.hubspot_access_token.present?
          default_parameter_hash['access_token'] = Hubspot.config.hubspot_access_token
        else
          default_parameter_hash['hapikey'] = Hubspot.config.hubspot_key
        end
        
        default_parameter_hash
      end
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

      unless arguments.last.is_a?(Hash) && arguments.last.delete('skip_default_parameters')
        Hubspot::Connection.default_parameters.to_param.tap do |default_parameters|
          if uri.query.present?
            uri.query += '&' + default_parameters
          else
            uri.query = default_parameters
          end
        end
      end
      
      super(method, uri.to_s, *arguments)
    end
       
  end

end