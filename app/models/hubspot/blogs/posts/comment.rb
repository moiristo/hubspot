module Hubspot
  module Blogs
    module Posts
    
      # This type of Comment will be instantiated when finding comments that belong to Posts
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