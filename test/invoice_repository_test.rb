require_relative 'test_helper.rb'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @data_1 = { 
      :id => 6, 
      :customer_id => 7, 
      :merchant_id => 8, 
      :status => "pending", 
      :created_at => Time.now, 
      :updated_at => Time.now,
    }
    @data_2 = { 
      :id => 7, 
      :customer_id => 2, 
      :merchant_id => 5, 
      :status => "approved", 
      :created_at => Time.now, 
      :updated_at => Time.now,
    }
    @invoices_data = [@data_1, @data_2]
    @invoices = InvoiceRepository.create_invoices(@invoices_data)
    
  end
  
  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices
  end
  
  def test_it_holds_invoices
    i_1 = Invoice.new(@data_1)
    invoice = InvoiceRepository.new([i_1])
    assert_equal [i_1], invoice.repository
  end
  
  def test_it_creates_invoices
    assert_instance_of Invoice, @invoices.repository[0]
    assert_equal 7, @invoices.repository[0].customer_id
    assert_instance_of Invoice, @invoices.repository[1]
    assert_equal 5, @invoices.repository[1].merchant_id
  end
  
  def test_it_returns_all_subclasses
    actual = @invoices.all
    assert_instance_of Invoice, actual[0]
    assert_equal 2, actual.length 
  end

  def test_it_finds_by_id
    assert_nil @invoices.find_by_id(4)
    assert_equal @invoices.repository[1], @invoices.find_by_id(7)
  end

  def test_it_finds_all_by_customer_id

    assert_equal [], @invoices.find_all_by_customer_id(5)
    assert_equal [@invoices.repository[1]], @invoices.find_all_by_customer_id(2)
  end
  
  def test_it_finds_all_by_merchant_id

    assert_equal [], @invoices.find_all_by_merchant_id(2)
    assert_equal [@invoices.repository[1]], @invoices.find_all_by_merchant_id(5)
  end

  def test_it_finds_all_by_status
    assert_equal [], @invoices.find_all_by_status("void")
    assert_equal [@invoices.repository[1]], @invoices.find_all_by_status("approved")
  end

  def test_it_creates_new_invoice_with_attributes
    actual = @invoices.create({ 
      :customer_id => 2, 
      :merchant_id => 5, 
      :status => "approved", 
      :created_at => Time.now, 
      :updated_at => Time.now,
    })
    expected = @invoices.repository.max_by { |x| x.id}
    assert_equal expected, actual.last
  end

  def test_it_updates_attributes
    expected = @invoices.repository[1]
    assert_equal "approved", expected.status
    actual = @invoices.update(7, {
      status: "void",
    })
    assert_equal expected, actual
    assert_equal "void", expected.status
  end

  def test_it_can_delete_an_id
    item_1 = @invoices.repository[0]
    item_2 = @invoices.repository[1]
    assert_equal [item_1, item_2], @invoices.repository
    @invoices.delete(6)
    assert_equal [item_2], @invoices.repository
  end
end