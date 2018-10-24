require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require 'pry'


class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_1 = Merchant.new({:id=>5, :name=>"Nixon"})
    @mr = MerchantRepository.new([@merchant_1])
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_holds_merchants
    assert_equal [@merchant_1], @mr.merchants
  end

  def test_it_creates_merchants
    incoming_data =[
      {:id => 1, :name => "Tony", :updated => 2014}, 
      {:id => 2, :name => "Ali", :updated => 2014},
      {:id => 3, :name => "Michael", :updated => 2014}
    ]

    mr = MerchantRepository.create_merchants(incoming_data)

    assert_instance_of Merchant, mr.merchants[0]
    assert_equal "Tony", mr.merchants[0].name
    assert_instance_of Merchant, mr.merchants[1]
    assert_equal "Ali", mr.merchants[1].name
    assert_instance_of Merchant, mr.merchants[2]
    assert_equal "Michael", mr.merchants[2].name
  end
end
