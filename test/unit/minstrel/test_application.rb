require 'helper'

class TestApplication < Test::Unit::TestCase
  include Rack::Test::Methods
  include XhrHelper

  def app
    Minstrel::Application
  end

  def setup
    OmniAuth.config.add_mock(:developer, {
      :provider => 'developer',
      :uid => 'foo',
      :info => {
        :name => 'bar'
      }
    })
  end

  test "index" do
    get '/'
    assert last_response.ok?
    assert_match "sup?", last_response.body
  end

  test "logging in with new identity and valid name" do
    Minstrel::Identity.expects(:[]).
      with(:uid => 'foo', :provider => 'developer').
      returns(nil)

    identity = stub('identity')
    Minstrel::Identity.expects(:new).
      with(:uid => 'foo', :provider => 'developer').
      returns(identity)
    identity.expects(:save)

    user = stub('user')
    Minstrel::User.expects(:new).with(:name => 'bar').returns(user)
    user.expects(:valid?).returns(true)
    user.expects(:save)

    post '/auth/developer/callback', {},
      {'omniauth.auth' => OmniAuth.config.mock_auth[:developer]}
    assert_equal "http://example.org/", last_response['location']
  end
end
