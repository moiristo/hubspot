module Hubspot
  
  # Finds blogs
  #
  # Finds:
  # Hubspot::Blog.find :all, :params => { :max => 10 }
  # Hubspot::Blog.find <GUID>  
  class Blog < Hubspot::Base
    self.site = 'https://api.hubapi.com/blog/v1'
    
    schema do
      string 'guid', 'blogTitle', 'feedUrl', 'jsonUrl', 'webUrl'
    end
    
    alias_attribute :id, :guid
    
    # Convenience methods for retrieving a blog's posts and comments
    
    def comments(params = {})
      Hubspot::Blogs::Comment.find :all, :params => params.merge(:blog_guid => guid)
    end
    
    def posts(params = {})
      Hubspot::Blogs::Post.find :all, :params => params.merge(:blog_guid => guid)
    end

    # Explicitly set element path 
    def self.element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{URI.escape id.to_s}.#{format.extension}#{query_string(query_options)}"
    end   
  
  end
  
end