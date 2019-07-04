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

  def test_accessor_methods
    user = User.create!
    assert user.active?
    assert !user.archived?
  end

  def test_state_change_methods
    user = User.create!
    user.archived!
    assert user.archived?
    user.reload
    assert user.archived?
    user.active!
    assert user.active?
    user.reload
    assert user.active?
  end

  def test_validation
    user = User.new(status: "unknown")
    assert !user.save
    assert_equal ["Status is not included in the list"], user.errors.full_messages
  end

  def test_list_values
    assert_equal %w(active archived), User.statuses
  end

  def test_prefix_scopes
    User.create!
    assert_equal 1, User.address_active.count
    assert_equal 0, User.address_archived.count
  end

  def test_prefix_accessors
    user = User.create!
    assert user.address_active?
    assert !user.address_archived?
  end

  def test_suffix_scopes
    User.create!
    assert_equal 1, User.guest_kind.count
    assert_equal 0, User.vip_kind.count
  end

  def test_suffix_accessors
    user = User.create!
    assert user.guest_kind?
    assert !user.vip_kind?
  end

  def test_select
    User.create!
    assert_equal 1, User.active.select(:id).map { |v| v }.size
  end
end
