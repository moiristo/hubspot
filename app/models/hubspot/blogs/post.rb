module Hubspot
  module Blogs
    class Post < Hubspot::Blogs::BlogAssociation
      
      # Convenience method for retrieving a post's comments
      def comments(params = {})
        Hubspot::Blogs::Posts::Comment.find :all, :params => params.merge(:post_guid => guid)
      end
    
    end
  end
end