require File.expand_path('../../test_helper.rb', __FILE__)

class KeywordTest < ActiveSupport::TestCase

  def test_should_return_keywords
    VCR.use_cassette('keywords-list') do
      keywords = Hubspot::Keyword.find(:all, :params => { :max => 5 })
      assert keywords.any?
            
      keyword = keywords.first
      assert_equal ["hapipy_test_keyword838"], Hubspot::Keyword.known_attributes.map{|attribute| keyword.send(attribute)}
    end  
  end  
  
  def test_should_create_keywords
    VCR.use_cassette('keyword-create') do
      assert keyword = Hubspot::Keyword.create({ :keyword => { :keyword => 'sleutel' }})
      assert_equal "1a33db71-3371-45c3-9e43-42ee24288d15", keyword.id
    end     
  end

end