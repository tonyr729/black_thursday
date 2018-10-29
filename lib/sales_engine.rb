require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/invoice'
require_relative '../lib/sales_analyst'
require 'csv'

class SalesEngine

  attr_reader :items_csv, :merchants_csv, :merchants, :items, :invoices, :analyst

  def initialize(csv_files)
    @merchants = merchants_factory(csv_files[:merchants]) if csv_files[:merchants]
    @items = items_factory(csv_files[:items]) if csv_files[:items]
    @invoices = invoice_factory(csv_files[:invoices]) if csv_files[:invoices]
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices)
  end

  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def merchants_factory(merchants_csv)
    parsed_merchants_data = csv_parser(merchants_csv)
    MerchantRepository.create_merchants(parsed_merchants_data)
  end

  def items_factory(items_csv)
    parsed_items_data = csv_parser(items_csv)
    ItemRepository.create_items(parsed_items_data)
  end

  def invoice_factory(invoices_csv)
    parsed_invoices_data = csv_parser(invoices_csv)
    InvoiceRepository.create_invoices(parsed_invoices_data)
  end

  def csv_parser(csv_path)
    file = CSV.read(csv_path, headers: true, header_converters: :symbol)
    file.map {|row| row.to_h}
  end

end
