require_relative '../test/test_helper.rb'
require_relative '../lib/invoice.rb'

class InvoiceTest < Minitest::Test
  def setup
    @data = {
      :id          => 1,
      :customer_id => 1,
      :merchant_id => 1,
      :status      => "Pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    @i = Invoice.new(@data)
  end

  def test_it_exists
    assert_instance_of Invoice, @i
  end

  def test_it_has_id
    assert_equal @data[:id].to_i, @i.id
  end

  def test_it_has_customer_id
    assert_equal @data[:customer_id].to_i, @i.customer_id
  end
  
  def test_it_has_merchant_id
    assert_equal @data[:merchant_id].to_i, @i.merchant_id
  end

  def test_it_has_status
    assert_equal @data[:status].to_sym, @i.status
  end

  def test_it_has_create_at_time
    assert_equal @data[:created_at].to_s, @i.created_at.to_s
  end
  
  def test_it_has_created_instance_of_time
    assert_instance_of Time, @i.created_at
  end

  def test_it_has_update_at_time
    assert_equal @data[:updated_at].to_s, @i.updated_at.to_s
  end
  
  def test_it_has_updated_instance_of_time
    assert_instance_of Time, @i.updated_at
  end
end
