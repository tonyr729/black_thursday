require_relative '../lib/bt_methods'

class MerchantRepository
  include BTMethods
  attr_reader :repository

  def initialize(merchants)
    @repository = merchants
    @new_instance = Merchant
  end

  def self.create_merchants(merchants_data)
    merchant_list = merchants_data.map do |merchant_data|
      Merchant.new({
        id: merchant_data[:id],
        name: merchant_data[:name]
      })
    end
    self.new(merchant_list)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
