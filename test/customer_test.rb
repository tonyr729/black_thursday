require_relative 'test_helper.rb'
require './lib/customer'
require 'time'

class CustomerTest < Minitest::Test
  def setup
    @data = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @customer = Customer.new(@data)
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_id
    assert_equal @data[:id], @customer.id
  end

  def test_it_has_first_name
    assert_equal @data[:first_name], @customer.first_name
  end

  def test_it_has_last_name
    assert_equal @data[:last_name], @customer.last_name
  end

  def test_it_has_created_at
    actual = @customer.created_at.to_s
    expected = @data[:created_at].to_s
    assert_equal expected, actual
  end

  def test_it_has_updated_at
    actual = @customer.updated_at.to_s
    expected = @data[:updated_at].to_s
    assert_equal expected, actual
  end
end
