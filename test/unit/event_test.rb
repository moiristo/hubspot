require File.expand_path('../../test_helper.rb', __FILE__)

class EventTest < ActiveSupport::TestCase

  def test_should_return_events
    VCR.use_cassette('events-list') do
      events = Hubspot::Event.find(:all, :params => { :max => 5 })
      assert_equal 5, events.size
            
      event = events.first
      assert_equal ["Atom Updated Atom-Powered Robots Run Amok", "iReach Distribution", "", 1333085425000], Hubspot::Event.known_attributes.map{|attribute| event.send(attribute)}
    end  
  end  
  
  def test_should_create_events
    VCR.use_cassette('event-create') do
      assert_equal 201, Hubspot::Event.create(:eventType => 'new event', :description => 'test', :url => 'http://dev.hubspot.com', :createDate => '1323272544000')
    end     
  end

end