require 'helper'

class TestAuthentication < Test::Unit::TestCase
  def new_authentication(attribs = {})
    Minstrel::Authentication.new({
      :user_id => 1,
      :identity_id => 1
    }.merge(attribs))
  end

  test "subclass of Sequel::Model" do
    assert_equal Sequel::Model, Minstrel::Authentication.superclass
  end

  test "requires user_id" do
    auth = new_authentication(:user_id => nil)
    assert !auth.valid?
  end

  test "requires identity_id" do
    auth = new_authentication(:identity_id => nil)
    assert !auth.valid?
  end
end
