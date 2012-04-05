module Hubspot
  module Blogs
    module Posts
    
      # Define an assocation base class from which blog child associations should inherit    
      class Comment < Hubspot::Base
        self.site = 'https://api.hubapi.com/blog/v1/posts/:post_guid'
      
        alias_attribute :id, :guid
        
        class << self
          
          def collection_path(prefix_options = {}, query_options = nil)
            prefix_options, query_options = split_options(prefix_options) if query_options.nil?
            "#{prefix(prefix_options)}comments.#{format.extension}#{query_string(query_options)}"
          end           
          
        end
      end
      
    end
  end
end