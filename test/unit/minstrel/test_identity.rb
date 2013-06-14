require 'helper'

class TestIdentity < Test::Unit::TestCase
  def new_identity(attribs = {})
    Minstrel::Identity.new({
      :uid => 'foo',
      :provider => 'bar'
    }.merge(attribs))
  end

  test "subclass of Sequel::Model" do
    assert_equal Sequel::Model, Minstrel::Identity.superclass
  end

  test "requires uid" do
    identity = new_identity(:uid => nil)
    assert !identity.valid?
  end

  test "requires provider" do
    identity = new_identity(:provider => nil)
    assert !identity.valid?
  end
end
