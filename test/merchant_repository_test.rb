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
end
