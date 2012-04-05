require File.expand_path('../../test_helper.rb', __FILE__)

class PostTest < ActiveSupport::TestCase
  
  def test_should_find_post_by_guid
    VCR.use_cassette('post-find') do
      post = Hubspot::Blogs::Post.find "6ca6fdc5-a81f-44db-a63b-f56ab2636c69", :params => { :blog_guid => "0d61e4ca-e395-4c1c-8766-afaa48bf68db" }
      assert_not_nil post
      assert_equal 'This is a test summary', post.summary
    end    
  end
  
  def test_should_return_post_comments
    VCR.use_cassette('post-comments') do
      post = Hubspot::Blogs::Post.find "6ca6fdc5-a81f-44db-a63b-f56ab2636c69", :params => { :blog_guid => "0d61e4ca-e395-4c1c-8766-afaa48bf68db" }
      assert post.comments(:max => 2).empty?
    end    
  end 

end