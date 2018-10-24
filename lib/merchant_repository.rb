class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
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
end
