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
    @invoice = Invoice.new(@data)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_id
    assert_equal @data[:id].to_i, @invoice.id
  end

  def test_it_has_customer_id
    assert_equal @data[:customer_id].to_i, @invoice.customer_id
  end
  
  def test_it_has_merchant_id
    assert_equal @data[:merchant_id].to_i, @invoice.merchant_id
  end

  def test_it_has_status
    assert_equal @data[:status], @invoice.status
  end

  def test_it_has_create_at_time
    assert_equal @data[:created_at].to_s, @invoice.created_at.to_s
  end
  
  def test_it_has_instance_of_time
    assert_instance_of Time, @invoice.created_at
  end

  def test_it_has_update_at_time
    assert_equal @data[:updated_at].to_s, @invoice.updated_at.to_s
  end
  
  def test_it_has_instance_of_time
    assert_instance_of Time, @invoice.updated_at
  end
end