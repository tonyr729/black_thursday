require_relative '../lib/bt_methods'

class CustomerRepository
  include BTMethods
  attr_reader :repository

  def initialize(customer)
    @repository = customer
    @new_instance = Customer
  end

  def self.create_customers(customers_data)
    customer_list = customers_data.map do |customer_data|
      Customer.new(customer_data)
    end
    self.new(customer_list)
  end

  def find_all_by_first_name(name)
    where_any(name, "first_name")
  end

  def find_all_by_last_name(name)
    where_any(name, "last_name")
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
