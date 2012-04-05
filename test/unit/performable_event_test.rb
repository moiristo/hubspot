require File.expand_path('../../test_helper.rb', __FILE__)

class PerformableEventTest < ActiveSupport::TestCase
  setup do
    @event = Hubspot::Performable::Event.new('event-12345', Date.civil(2012), nil, 'http://example.com')
  end
  
  def test_should_create_query_string
    assert_equal "_a=demo&_l=http%3A%2F%2Fexample.com&_n=event-12345&_t=2012-01-01", @event.to_param
    
    @event.custom_parameters = { :email => 'test@example.com' }
    assert_equal "_a=demo&_l=http%3A%2F%2Fexample.com&_n=event-12345&_t=2012-01-01&email=test%40example.com", @event.to_param
  end  
  
  def test_should_record_events
    VCR.use_cassette('event-record') do
      @event.custom_parameters = { :email => 'test@example.com' }  
      assert_equal 200, @event.record
    end    
  end

end