require "active_resource"

module Hubspot

  class Base < ActiveResource::Base    
    self.format = ActiveResource::Formats::JsonFormat
    self.include_root_in_json = false  
    
    # Only serialize the attributes listed in the schema
    def to_json(options={})
      super(options.reverse_merge(:only => schema.keys))
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
