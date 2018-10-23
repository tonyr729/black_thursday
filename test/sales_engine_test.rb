require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require 'pry'


class SalesEngineTest < Minitest::Test
  def setup
    @data = { 
      :items => "./data/items.csv", 
      :merchants => "./data/merchants.csv",
    }
    @se = SalesEngine.new(@data)
  end
  
  def test_it_can_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_items_csv_data
    assert_equal @data[:items], @se.items_csv
  end
  
  def test_it_has_merchant_csv_data
    assert_equal @data[:merchants], @se.merchants_csv
  end

  def test_it_can_create_a_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_parses_csv_data
    expected = [
      {
        :id=>"12334105", 
        :name=>"Shopin1901", 
        :created_at=>"2010-12-10", 
        :updated_at=>"2011-12-04"
      }, 
      {
        :id=>"12334112", 
        :name=>"Candisart", 
        :created_at=>"2009-05-30", 
        :updated_at=>"2010-08-29"
      }, 
      {
        :id=>"12334113", 
        :name=>"MiniatureBikez", 
        :created_at=>"2010-03-30", 
        :updated_at=>"2013-01-21"
      }
    ]

    assert_equal expected, @se.csv_parser("./data/mock_data.csv")
  end
end
