require_relative '../test/test_helper'
require 'bigdecimal'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/merchant'
require 'pry'

class SalesAnalystTest < MiniTest::Test

  def setup
    @item_1 = Item.new({id: 1, name: "Golden Shovel", description: "A poetic book", unit_price: "4000000", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_2 = Item.new({id: 2, name: "Thundervest", description: "Interesting things", unit_price: "4000", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_3 = Item.new({id: 3, name: "Burger", description: "a", unit_price: "1002", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_4 = Item.new({id: 4, name: "Noodle", description: "b", unit_price: "1003", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_5 = Item.new({id: 5, name: "Hawt Dawg", description: "c", unit_price: "10054", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_6 = Item.new({id: 6, name: "Regular Hot Dog", description: "d", unit_price: "40094", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_7 = Item.new({id: 7, name: "Corn dog", description: "e", unit_price: "30098", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_8 = Item.new({id: 8, name: "Chicago dog", description: "f", unit_price: "40032", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_9 = Item.new({id: 9, name: "Tree", description: "g", unit_price: "400051", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_10 = Item.new({id: 10, name: "Mountain", description: "h", unit_price: "40002", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_11 = Item.new({id: 11, name: "Doctor Costume", description: "i", unit_price: "4007", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_12 = Item.new({id: 12, name: "Pumpkin", description: "j", unit_price: "5005", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_13 = Item.new({id: 13, name: "Grilled Chicken Breast", description: "i", unit_price: "500", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_14 = Item.new({id: 14, name: "$600 Noodles and Company Gift Card", description: "k", unit_price: "500", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_15 = Item.new({id: 15, name: "Mom's Beef Stroganoff", description: "yum", unit_price: "900801", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_16 = Item.new({id: 16, name: "Corn hog", description: "l", unit_price: "600", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_17 = Item.new({id: 17, name: "Burger in a blanket", description: "m", unit_price: "9009", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    @item_18 = Item.new({id: 18, name: "TEMPUR-Flex® Supreme Breeze", description: "zzzzzzzzz", unit_price: "100", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    @item_19 = Item.new({id: 19, name: "Bag o' ricardos", description: "z", unit_price: "60050", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    @item_20 = Item.new({id: 20, name: "Funyuns", description: "rfghnm", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    @item_21 = Item.new({id: 21, name: "Black beans", description: "treqtrt", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_22 = Item.new({id: 22, name: "Logitech Mouse", description: "bgrebgr", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_23 = Item.new({id: 23, name: "LG TV", description: "yes", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_24 = Item.new({id: 24, name: "Men's multivitamin", description: "grgb", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @item_25 = Item.new({id: 25, name: "Grandma's Pumpkin Quick Bread", description: "x", unit_price: "2500", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    @items = [@item_1, @item_2, @item_3, @item_4, @item_5, @item_6, @item_7, @item_8, @item_9, @item_10, @item_11, @item_12, @item_13, @item_14, @item_15, @item_16, @item_17, @item_18, @item_19, @item_20, @item_21, @item_22, @item_23, @item_24, @item_25]

    @merchant_1 = Merchant.new({id: 25, name: "Useless Collectibles"})
    @merchant_2 = Merchant.new({id: 35, name: "doganxiety.bacon"})
    @merchant_3 = Merchant.new({id: 45, name: "nationalcorndogday.com"})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]

    @invoice_1 = Invoice.new({:id => 1, :customer_id => 10, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_2 = Invoice.new({:id => 2, :customer_id => 9, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_3 = Invoice.new({:id => 3, :customer_id => 8, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_4 = Invoice.new({:id => 4, :customer_id => 7, :merchant_id => 25, :status => :shipped, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_5 = Invoice.new({:id => 5, :customer_id => 6, :merchant_id => 25, :status => :shipped, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_6 = Invoice.new({:id => 6, :customer_id => 5, :merchant_id => 25, :status => :returned, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_7 = Invoice.new({:id => 7, :customer_id => 4, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_8 = Invoice.new({:id => 8, :customer_id => 3, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_9 = Invoice.new({:id => 9, :customer_id => 2, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_10 = Invoice.new({:id => 10, :customer_id => 1, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_11 = Invoice.new({:id => 11, :customer_id => 10, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_12 = Invoice.new({:id => 12, :customer_id => 10, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_13 = Invoice.new({:id => 13, :customer_id => 10, :merchant_id => 25, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_14 = Invoice.new({:id => 14, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_15 = Invoice.new({:id => 15, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_16 = Invoice.new({:id => 16, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_17 = Invoice.new({:id => 17, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_18 = Invoice.new({:id => 18, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_19 = Invoice.new({:id => 19, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_20 = Invoice.new({:id => 20, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_21 = Invoice.new({:id => 21, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_22 = Invoice.new({:id => 22, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_23 = Invoice.new({:id => 23, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_24 = Invoice.new({:id => 24, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_25 = Invoice.new({:id => 25, :customer_id => 10, :merchant_id => 35, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_26 = Invoice.new({:id => 26, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_27 = Invoice.new({:id => 27, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_28 = Invoice.new({:id => 28, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_29 = Invoice.new({:id => 29, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_30 = Invoice.new({:id => 30, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_31 = Invoice.new({:id => 31, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_32 = Invoice.new({:id => 32, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_33 = Invoice.new({:id => 33, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_34 = Invoice.new({:id => 34, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_35 = Invoice.new({:id => 35, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_36 = Invoice.new({:id => 36, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_37 = Invoice.new({:id => 37, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_38 = Invoice.new({:id => 38, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    @invoice_39 = Invoice.new({:id => 39, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})
    # @invoice_40 = Invoice.new({:id => 40, :customer_id => 10, :merchant_id => 45, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now})

    @invoices = [@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5, @invoice_6, @invoice_7, @invoice_8, @invoice_9, @invoice_10,
      @invoice_11, @invoice_12, @invoice_13, @invoice_14, @invoice_15, @invoice_16, @invoice_17, @invoice_18, @invoice_19, @invoice_20,
      @invoice_21, @invoice_22, @invoice_23, @invoice_24, @invoice_25, @invoice_26, @invoice_27, @invoice_28, @invoice_29, @invoice_30,
      @invoice_31, @invoice_32, @invoice_33, @invoice_34, @invoice_35, @invoice_36, @invoice_37, @invoice_38, @invoice_39] #@invoice_40]

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
    expected = (@invoices.count.to_f / @merchants.count.to_f).round(2)
    assert_equal expected, actual
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    actual = @sa.average_invoices_per_merchant_standard_deviation
    expected = 9.29
    assert_equal expected, actual
  end

  def test_it_can_calculate_top_merchants_by_invoice_count
    actual = @sa.top_merchants_by_invoice_count
    expected = [@merchant_1]
    assert_equal expected, actual
  end


end
