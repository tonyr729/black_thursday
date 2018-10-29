require_relative 'test_helper.rb'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @data_1 = {
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => "1099",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @data_2 = {
      :id => 2,
      :item_id => 4,
      :invoice_id => 3,
      :quantity => 1,
      :unit_price => "544",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @invoice_items_data = [@data_1, @data_2]
    @iir = InvoiceItemRepository.create_invoice_items(@invoice_items_data)

  end

  def test_it_exists
    iir = InvoiceItemRepository.new(@data_1)
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_holds_invoice_items
    @item_1 = InvoiceItem.new(@data_1)
    iir = InvoiceItemRepository.new(@item_1)
    assert_equal @item_1, iir.repository
  end

  def test_it_creates_items
    assert_instance_of InvoiceItem, @iir.repository[0]
    assert_equal 7, @iir.repository[0].item_id
    assert_instance_of InvoiceItem, @iir.repository[1]
    assert_equal 1, @iir.repository[0].quantity
  end

  def test_it_returns_all_subclasses
    item_1 = @iir.repository[0]
    item_2 = @iir.repository[1]

    assert_equal 2, @iir.all.length
    assert_equal [item_1, item_2], @iir.all
  end

  def test_it_finds_by_id
    assert_nil @iir.find_by_id(4)
    assert_equal @iir.repository[1], @iir.find_by_id(2)
  end

  def test_it_finds_by_item_id
    assert_equal [], @iir.find_by_item_id(9)
    assert_equal [@iir.repository[1]], @iir.find_by_item_id(4)
  end

  def test_it_finds_all_with_invoice_id

    assert_equal [], @iir.find_all_with_invoice_id(5)
    assert_equal [@iir.repository[1]], @iir.find_all_with_invoice_id(3)
  end

  def test_it_creates_new_invoice_with_attributes
    actual = @iir.create({
      :id => 12,
      :item_id => 71,
      :invoice_id => 81,
      :quantity => 11,
      :unit_price => "1099",
      :created_at => Time.now,
      :updated_at => Time.now
    }).last
    expected = @iir.repository.max_by { |x| x.id}
    assert_equal expected, actual
  end

  def test_it_updates_attributes
    expected = @iir.repository[1]
    assert_equal 3, expected.invoice_id
    actual = @iir.update(2, {
      invoice_id: 4,
      quantity: 14
    })
    assert_equal expected, actual
    assert_equal 4, expected.invoice_id
    assert_equal 14, expected.quantity
  end

  def test_it_can_delete_an_id
    item_1 = @iir.repository[0]
    item_2 = @iir.repository[1]
    assert_equal [item_1, item_2], @iir.repository
    @iir.delete(2)
    assert_equal [item_1], @iir.repository
  end
end
