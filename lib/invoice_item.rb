require 'time'

class InvoiceItem

  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(invoice_item_info)
    sig_dig = invoice_item_info[:unit_price].exponent if invoice_item_info[:unit_price].class == BigDecimal
    sig_dig = invoice_item_info[:unit_price].length if invoice_item_info[:unit_price].class == String
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity = invoice_item_info[:quantity].to_i
    @unit_price = BigDecimal(invoice_item_info[:unit_price], sig_dig) / BigDecimal(100, sig_dig)
    @created_at = Time.now
    @updated_at = Time.now
  end

  def unit_price_to_dollars
    @unit_price.truncate(@unit_price.exponent).to_f
  end

end
