require_relative 'test_helper.rb'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require 'pry'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @data_1 = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @data_2 = {
      :id => 7,
      :first_name => "John",
      :last_name => "Smith",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @customers_data = [@data_1, @data_2]
    @customer_1 = Customer.new(@data_1)
    @cr = CustomerRepository.create_customers(@customers_data)
  end


  def test_it_exists
    cr = CustomerRepository.new([@customer_1])
    assert_instance_of CustomerRepository, cr
  end

  def test_it_holds_customers
    cr = CustomerRepository.new([@customer_1])
    assert_equal [@customer_1], cr.repository
  end

  def test_it_creates_customers
    cr = CustomerRepository.create_customers(@customers_data)
    assert_instance_of Customer, cr.repository[0]
    assert_equal "Joan", cr.repository[0].first_name
    assert_instance_of Customer, cr.repository[1]
    assert_equal "Smith", cr.repository[1].last_name
  end

  def test_it_returns_all_subclasses
    customer_1 = @cr.repository[0]
    customer_2 = @cr.repository[1]
    assert_equal [customer_1, customer_2], @cr.all
  end

  def test_it_finds_by_id
    assert_nil @cr.find_by_id(4)
    assert_equal @cr.repository[1], @cr.find_by_id(7)
  end

  def test_it_finds_all_by_first_name
    assert_equal [@cr.repository[1]], @cr.find_all_by_first_name("John")
  end

  def test_it_finds_all_by_last_name
    assert_equal [@cr.repository[1]], @cr.find_all_by_last_name("Smith")
  end

  def test_it_creates_new_cr_with_attributes
    cr = CustomerRepository.create_customers(@customers_data)
    actual = cr.create({
      :id => 10,
      :first_name => "Harry",
      :last_name => "Potter",
      :created_at => Time.now,
      :updated_at => Time.now
    }).last
    expected = cr.repository.max_by { |x| x.id}
    assert_equal expected, actual
  end

  def test_it_updates_attributes
    cr = CustomerRepository.create_customers(@customers_data)
    expected = cr.repository[1]
    assert_equal "John", expected.first_name
    actual = cr.update(7, {
      first_name: "Hermione",
      last_name: "Granger"
    })
    assert_equal expected, actual
    assert_equal "Hermione", expected.first_name
    assert_equal "Granger", expected.last_name
  end

  def test_it_can_delete_an_id
    cr = CustomerRepository.create_customers(@customers_data)
    customer_1 = cr.repository[0]
    customer_2 = cr.repository[1]
    assert_equal [customer_1, customer_2], cr.repository
    cr.delete(7)
    assert_equal [customer_1], cr.repository
  end

end
