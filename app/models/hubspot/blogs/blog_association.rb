module Hubspot
  module Blogs
    
    # Define an assocation base class from which blog child associations should inherit    
    class BlogAssociation < Hubspot::Base
      self.site = Hubspot::Blog.site
      
      alias_attribute :id, :guid   
      
      class << self
        def element_path(id, prefix_options = {}, query_options = nil)
          prefix_options, query_options = split_options(prefix_options) if query_options.nil?
          "#{prefix(prefix_options)}#{collection_name}/#{URI.escape id.to_s}.#{format.extension}#{query_string(query_options)}"
        end      
    
        def collection_path(prefix_options = {}, query_options = nil)
          prefix_options, query_options = split_options(prefix_options) if query_options.nil?
          raise(ActiveResource::MissingPrefixParam, ":blog_guid prefix_option is missing") unless prefix_options[:blog_guid] && defined?(ActiveResource::MissingPrefixParam)
          "#{prefix(prefix_options)}#{prefix_options[:blog_guid].to_s}/#{collection_name}.#{format.extension}#{query_string(query_options)}"
        end      
    
        private
    
        def prefix_parameters
          @prefix_parameters ||= begin
            params = super
            params << :blog_guid
            params
          end
        end 
      end        
    end
    
  end
end