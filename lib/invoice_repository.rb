require_relative '../lib/bt_methods'
class InvoiceRepository
  include BTMethods
  attr_reader :repository

  def initialize(invoices)
    @repository = invoices
    @new_instance = Invoice
  end

  def self.create_invoices(invoices_data)
    invoice_list = invoices_data.map do |invoice_data|
      Invoice.new(invoice_data)
    end
    self.new(invoice_list)
  end

  def find_all_by_customer_id(customer_id)
    where_any(customer_id, "customer_id")
  end

  def find_all_by_merchant_id(merchant_id)
    where_any(merchant_id, "merchant_id")
  end

  def find_all_by_status(status)
    where_any(status, "status")
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
