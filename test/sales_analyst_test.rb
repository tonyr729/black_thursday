require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/merchant'

class SalesAnalystTest < MiniTest::Test

  def setup
    @item_1 = Item.new({id: 1, name: "Golden Shovel", description: "A poetic book", unit_price: "4000000", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_2 = Item.new({id: 2, name: "Thundervest", description: "Interesting things", unit_price: "4000", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_3 = Item.new({id: 3, name: "Burger", description: "a", unit_price: "1002", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_4 = Item.new({id: 4, name: "Noodle", description: "b", unit_price: "1003", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_5 = Item.new({id: 5, name: "Hawt Dawg", description: "c", unit_price: "10054", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    @item_6 = Item.new({id: 6, name: "Regular Hot Dog", description: "d", unit_price: "40094", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
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
    @item_20 = Item.new({id: 20, name: "Funyuns", description: "x", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    @items = [@item_1, @item_2, @item_3, @item_4, @item_5, @item_6, @item_7, @item_8, @item_9, @item_10, @item_11, @item_12, @item_13, @item_14, @item_15, @item_16, @item_17, @item_18, @item_19, @item_20]

    @merchant_1 = Merchant.new({id: 25, name: "Useless Collectibles"}),
    @merchant_2 = Merchant.new({id: 35, name: "doganxiety.bacon"}),
    @merchant_3 = Merchant.new({id: 45, name: "nationalcorndogday.com"})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]

    @mr = MerchantRepository.new(@merchants)
    @ir = ItemRepository.new(@items)
    @sa = SalesAnalyst.new
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_calculates_average_items_per_merchant
    binding.pry
    actual = @sa.average_items_per_merchant
    expected = (@items.count / @merchants.count.to_f)
    assert_equal expected, actual
  end



end
