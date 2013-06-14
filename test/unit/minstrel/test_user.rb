require 'helper'

class TestUser < Test::Unit::TestCase
  def new_user(attribs = {})
    Minstrel::User.new({
      :name => 'foo'
    }.merge(attribs))
  end

  test "subclass of Sequel::Model" do
    assert_equal Sequel::Model, Minstrel::User.superclass
  end

  test "requires name" do
    user = new_user(:name => nil)
    assert !user.valid?
  end

  test "requires unique name" do
    user_1 = new_user(:name => 'foo')
    user_1.save
    user_2 = new_user(:name => 'foo')
    assert !user_2.valid?
  end
end
