require "active_resource"

# Hubspot::Base initializes ActiveResource to use JSON and to use our own Connection class that adds authentication
# information to each request. Moreover, as Hubspot's API paths are very inconsistent, it provides the most common
# paths to object collections and members. This can be overridden if necessary
module Hubspot

  class Base < ActiveResource::Base
    self.format = ActiveResource::Formats::JsonFormat

    # Only serialize the attributes listed in the schema. Leads can contain much more information than can be passed
    # back to Hubspot, therefore we need to ensure they are not serialized on save.
    def to_json(options={})
      super(options.reverse_merge(:root => nil, :only => schema.keys))
    end     
    
    class << self
      
      # Use our own connection class
      def connection(refresh = false)
        @connection = Hubspot::Connection.new(site, format) if @connection.nil? || refresh
        return @connection
      end
      
      # ==== Set paths ====
      
      def element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name.singularize}/#{URI.escape id.to_s}.#{format.extension}#{query_string(query_options)}"
      end      
      
      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}list.#{format.extension}#{query_string(query_options)}"
      end      
      
    end
  end

end
