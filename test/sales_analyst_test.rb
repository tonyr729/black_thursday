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
    @mr = MerchantRepository.new(@mock_data.merchants)
    @ir = ItemRepository.new(@mock_data.items)
    @invr = InvoiceRepository.new(@mock_data.invoices)
    @sa = SalesAnalyst.new(@ir, @mr, @invr)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_calculates_average_items_per_merchant
    actual = @sa.average_items_per_merchant
    assert_equal 8.33, actual
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    expected = 9.29
    assert_equal expected, actual
  end

  def test_it_shows_merchants_with_high_item_count
    actual = @sa.merchants_with_high_item_count
    expected = [@merchant_3]
    assert_equal expected, actual
  end

  def test_it_has_average_item_price_for_merchant
    actual = @sa.average_item_price_for_merchant(25)
    expected = BigDecimal((@item_1.unit_price + @item_2.unit_price) / BigDecimal(2, 4))
    assert_equal expected, actual
  end

  def test_it_has_average_average_item_price_for_merchant
    actual = @sa.average_average_price_per_merchant
    expected = BigDecimal("7451.71")
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
    expected = [@item_1]
    assert_equal expected, actual
  end

  def test_it_calculates_average_invoices_per_merchant
    actual = @sa.average_invoices_per_merchant
    expected = (@mock_data.invoices.count.to_f / @mock_data.merchants.count.to_f).round(2)
    assert_equal expected, actual
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    actual = @sa.average_invoices_per_merchant_standard_deviation
    expected = 15.83
    assert_equal expected, actual
  end

  # def test_it_can_calculate_top_merchants_by_invoice_count
  #   actual = @sa.top_merchants_by_invoice_count
  #   expected = [@merchant_1]
  #   assert_equal expected, actual
  # end


end
