require File.expand_path('../../test_helper.rb', __FILE__)

class LeadTest < ActiveSupport::TestCase
  def test_should_return_leads
    VCR.use_cassette('leads-list') do
      leads = Hubspot::Lead.find(:all, :params => { :max => 10 })
      assert_equal 10, leads.size
            
      lead = leads.first
      assert_equal ["8a41f2f22906b93a012906b9438f0008", "", "rein", "Kanaki", "adrian@hubspot.com", "http://hubspot.com", "Proquest", "", "Maharashtra", "<a href=\"http://boston.com\">Boston</a>", "12", "etas unis", "321-123-3211", "1231231234", "123", "", "Devloper", "adrianmott", "123.321.123.321", 90.6981], Hubspot::Lead.known_attributes.map{|attribute| lead.send(attribute)}
    end
  end
  
  def test_should_find_lead_by_guid
    VCR.use_cassette('lead-find') do
      lead = Hubspot::Lead.find("8a41f2f22906b93a012906b9438f0008")
      assert_not_nil lead
      assert_equal ["8a41f2f22906b93a012906b9438f0008", "", "rein", "Kanaki", "adrian@hubspot.com", "http://hubspot.com", "Proquest", "", "Maharashtra", "<a href=\"http://boston.com\">Boston</a>", "12", "etas unis", "321-123-3211", "1231231234", "123", "", "Devloper", "adrianmott", "123.321.123.321", 90.6981], Hubspot::Lead.known_attributes.map{|attribute| lead.send(attribute)}
    end    
  end
  
  def test_should_update_lead
    VCR.use_cassette('lead-update') do
      lead = Hubspot::Lead.find("8a41f2f22906b93a012906b9438f0008")
      assert lead.update_attributes(:firstName => 'John')
      
      lead.reload
      assert_equal ["8a41f2f22906b93a012906b9438f0008", "", "John", "Kanaki", "adrian@hubspot.com", "http://hubspot.com", "Proquest", "", "Maharashtra", "<a href=\"http://boston.com\">Boston</a>", "12", "etas unis", "321-123-3211", "1231231234", "123", "", "Devloper", "adrianmott", "123.321.123.321", 90.6981], Hubspot::Lead.known_attributes.map{|attribute| lead.send(attribute)}
    end
  end  
end