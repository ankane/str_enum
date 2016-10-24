require_relative "test_helper"

class StrEnumTest < Minitest::Test
  def setup
    User.delete_all
  end

  def test_default
    user = User.new
    assert_equal "active", user.status
  end

  def test_scopes
    User.create!
    assert_equal 1, User.active.count
    assert_equal 0, User.archived.count
  end

  def test_accessors
    user = User.create!
    assert user.active?
    assert !user.archived?
  end

  def test_validation
    user = User.new(status: "unknown")
    assert !user.save
    assert_equal ["Status is not included in the list"], user.errors.full_messages
  end
end
