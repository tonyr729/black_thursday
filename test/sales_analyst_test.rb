require_relative '../test/test_helper'
require 'bigdecimal'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/mock_data.rb'
require 'pry'

class SalesAnalystTest < MiniTest::Test
  def setup
    @mock_data = MockData.new
    @merchants = @mock_data.merchants
    @items = @mock_data.items
    @invoices = @mock_data.invoices
    @mr = MerchantRepository.new(@merchants)
    @ir = ItemRepository.new(@items)
    @invr = InvoiceRepository.new(@invoices)
    @sa = SalesAnalyst.new(@ir, @mr, @invr)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_calculates_average_items_per_merchant
    actual = @sa.average_items_per_merchant
    assert_equal 3.13, actual
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    expected = 2.86
    assert_equal expected, actual
  end

  def test_it_shows_merchants_with_high_item_count
    actual = @sa.merchants_with_high_item_count
    expected = [@merchants[5]]
    assert_equal expected, actual
  end

  def test_it_has_average_item_price_for_merchant
    actual = @sa.average_item_price_for_merchant(25)
    expected = BigDecimal("40000")
    assert_equal expected, actual
  end

  def test_it_has_average_average_item_price_for_merchant
    actual = @sa.average_average_price_per_merchant
    expected = BigDecimal("5633.28")
    assert_equal expected, actual
  end

  def test_it_can_find_average_item_price
    actual = @sa.average_item_price_finder
    expected = BigDecimal("2821.3632")
    assert_equal expected, actual
  end

  def test_it_can_calculate_standard_deviation_for_item_prices
    actual = @sa.item_price_standard_deviation
    expected = 8021.7
    assert_equal expected, actual
  end

  def test_it_finds_golden_items
    actual = @sa.golden_items
    expected = [@items[0]]
    assert_equal expected, actual
  end

  def test_it_calculates_average_invoices_per_merchant
    actual = @sa.average_invoices_per_merchant
    expected = (@invoices.count / @merchants.count.to_f).round(2)
    assert_equal expected, actual
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    actual = @sa.average_invoices_per_merchant_standard_deviation
    expected = 4.72
    assert_equal expected, actual
  end

  def test_it_can_calculate_top_merchants_by_invoice_count
    actual = @sa.top_merchants_by_invoice_count
    expected = [@merchants[6]]
    assert_equal expected, actual
  end

  def test_it_can_calculate_bottom_merchants_by_invoice_count
    actual = @sa.bottom_merchants_by_invoice_count
    expected = [@merchants[0], @merchants[1], @merchants[2], @merchants[3], @merchants[7]]
    assert_equal expected, actual
  end

  def test_it_calculates_top_days_by_invoice_count
    actual = @sa.top_days_by_invoice_count
    expected = ["Sunday"]
    binding.pry
    assert_equal expected, actual
  end



end
