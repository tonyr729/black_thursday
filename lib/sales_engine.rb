require_relative '../lib/merchant_repository'
require 'csv'

class SalesEngine
  attr_reader :items_csv, :merchants_csv
  def initialize(csv_files)
    @items_csv = csv_files[:items]
    @merchants_csv = csv_files[:merchants]
  end

  def merchants
    merchants = csv_parser(@merchants_csv)

    MerchantRepository.create_merchants(merchants)
  end

  def csv_parser(csv_path)
    file = CSV.read(csv_path, headers: true, header_converters: :symbol)

    file.map {|row| row.to_h}
  end
end
