require_relative '../lib/bt_methods'
require_relative '../lib/invoice_item'
require 'bigdecimal'

class InvoiceItemRepository
  include BTMethods
  attr_reader :repository

  def initialize(items)
    @repository = items
    @new_instance = InvoiceItem
  end

  def self.create_invoice_items(invoice_items_data)
    invoice_item_list = invoice_items_data.map do |invoice_item_data|
      InvoiceItem.new(invoice_item_data)
    end
    self.new(invoice_item_list)
  end

  def find_by_item_id(item_id)
    where_any(item_id, "item_id")
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
