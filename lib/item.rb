require 'time'

class Item

  attr_accessor :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_info)
    sig_dig = item_info[:unit_price].exponent if item_info[:unit_price].class == BigDecimal
    sig_dig = item_info[:unit_price].length if item_info[:unit_price].class == String

    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = BigDecimal(item_info[:unit_price], sig_dig) / BigDecimal(100, sig_dig)
    @created_at = Time.parse(item_info[:created_at].to_s)
    @updated_at = Time.parse(item_info[:updated_at].to_s)
    @merchant_id = item_info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.truncate(@unit_price.exponent).to_f
  end

end
