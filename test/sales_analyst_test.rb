require_relative '../test/test_helper'
require 'bigdecimal'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/mock_data.rb'
require 'pry'

class SalesAnalystTest < MiniTest::Test
  def setup
    @mock_data = MockData.new
    @merchants = @mock_data.merchants
    @items = @mock_data.items
    @invoices = @mock_data.invoices
    @transactions = @mock_data.transactions
    @invoice_item = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => "1099",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @mr = MerchantRepository.new(@merchants)
    @ir = ItemRepository.new(@items)
    @invr = InvoiceRepository.new(@invoices)
    @tr = TransactionRepository.new(@transactions)
    @iir = InvoiceItemRepository.new([@invoice_item])
    @sa = SalesAnalyst.new(@ir, @mr, @invr, @iir, @tr)
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
    expected = 2.82
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
    expected = ["Monday"]
    assert_equal expected, actual
  end

  def test_it_returns_percentage_of_invoices_by_status
    actual_1 = @sa.invoice_status(:pending)
    actual_2 = @sa.invoice_status(:shipped)
    actual_3 = @sa.invoice_status(:returned)

    expected_1 = 86.11
    expected_2 = 8.33
    expected_3 = 5.56

    assert_equal expected_1, actual_1
    assert_equal expected_2, actual_2
    assert_equal expected_3, actual_3

  end

  def test_it_checks_if_any_invoice_is_paid_in_full
    actual = @sa.invoice_paid_in_full?(8)
    assert actual
  end

  def test_it_can_give_invoice_total
    actual = @sa.invoice_total(8)
    expected = 10.99
    assert_equal expected, actual
  end

  def test_it_gives_merchant_invoices
    merchant = @merchants.first
    actual = @sa.merchants_with_invoices
    expected = [@invoices[0]]
    assert_equal expected, actual[merchant]
  end

end
