require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/sales_analyst'
require 'csv'

class SalesEngine

  attr_reader :items_csv, :merchants_csv, :merchants, :items, :analyst

  def initialize(csv_files)
    @items_csv = csv_files[:items]
    @merchants_csv = csv_files[:merchants]
    @merchants = merchants_factory
    @items = items_factory
    @analyst = SalesAnalyst.new
  end

  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def merchants_factory
    parsed_merchants_data = csv_parser(@merchants_csv)
    MerchantRepository.create_merchants(parsed_merchants_data)
  end

  def items_factory
    parsed_items_data = csv_parser(@items_csv)
    ItemRepository.create_items(parsed_items_data)
  end

  def csv_parser(csv_path)
    file = CSV.read(csv_path, headers: true, header_converters: :symbol)
    file.map {|row| row.to_h}
  end

end
