require_relative 'test_helper.rb'
require 'bigdecimal'
require './lib/invoice_item'
require 'time'

class InvoiceItemTest < Minitest::Test
  def setup
    @data = {
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => "1099",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @ii = InvoiceItem.new(@data)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_id
    assert_equal @data[:id], @ii.id
  end

  def test_it_has_item_id
    assert_equal @data[:item_id], @ii.item_id
  end

  def test_it_has_invoice_id
    assert_equal @data[:invoice_id], @ii.invoice_id
  end

  def test_it_has_quantity
    assert_equal @data[:quantity], @ii.quantity
  end

  def test_it_has_unit_price
    expected = BigDecimal("1099", 4) / BigDecimal(100, 4)
    assert_equal expected, @ii.unit_price
  end

  def test_it_has_created_at
    actual = @ii.created_at.to_s
    expected = @data[:created_at].to_s
    assert_equal expected, actual
  end

  def test_it_has_updated_at
    actual = @ii.updated_at.to_s
    expected = @data[:updated_at].to_s
    assert_equal expected, actual
  end

  def test_it_can_change_the_unit_price_to_dollars
    assert_equal 10.99, @ii.unit_price_to_dollars
  end




end
