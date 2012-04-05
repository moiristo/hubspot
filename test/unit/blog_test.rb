require File.expand_path('../../test_helper.rb', __FILE__)

class BlogTest < ActiveSupport::TestCase
  
  def test_should_return_blogs
    VCR.use_cassette('blogs-list') do
      blogs = Hubspot::Blog.find(:all, :params => { :max => 5 })
      assert_equal 5, blogs.size
            
      blog = blogs.first
      assert_equal ["0d61e4ca-e395-4c1c-8766-afaa48bf68db", "Test Blog (content from customers.hubspot.com)", "demo.hubapi.com/CMS/UI/Modules/BizBlogger/rss.aspx?moduleId=584130&tabId=300291", "https://api.hubapi.com/blog/v1/0d61e4ca-e395-4c1c-8766-afaa48bf68db.json", "demo.hubapi.com/blog-for-testing"], Hubspot::Blog.known_attributes.map{|attribute| blog.send(attribute)}
    end
  end
  
  def test_should_find_blog_by_guid
    VCR.use_cassette('blog-find') do
      blog = Hubspot::Blog.find("0d61e4ca-e395-4c1c-8766-afaa48bf68db")
      assert_not_nil blog
      assert_equal ["0d61e4ca-e395-4c1c-8766-afaa48bf68db", "Test Blog (content from customers.hubspot.com)", "demo.hubapi.com/CMS/UI/Modules/BizBlogger/rss.aspx?moduleId=584130&tabId=300291", "https://api.hubapi.com/blog/v1/0d61e4ca-e395-4c1c-8766-afaa48bf68db.json", "demo.hubapi.com/blog-for-testing"], Hubspot::Blog.known_attributes.map{|attribute| blog.send(attribute)}
    end    
  end
  
  def test_should_return_blog_posts
    VCR.use_cassette('blog-posts') do
      blog = Hubspot::Blog.find("0d61e4ca-e395-4c1c-8766-afaa48bf68db")
      assert blog.posts(:max => 2).any?
    end
  end  
  
  def test_should_return_blog_comments
    VCR.use_cassette('blog-comments') do
      blog = Hubspot::Blog.find("0d61e4ca-e395-4c1c-8766-afaa48bf68db")
      assert blog.comments(:max => 2).any?
    end
  end  
  
end