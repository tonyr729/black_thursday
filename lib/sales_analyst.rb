require 'pry'
require_relative '../lib/maths.rb'
class SalesAnalyst
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions

  def initialize (items, merchants, invoices, invoice_items, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
    @item_prices_array = @items.repository.map { |item| item.unit_price }
  end

  def average_items_per_merchant
    (@items.repository.count / @merchants.repository.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_counts = @items.repository.group_by { |i| i.merchant_id }.map { |_k, v| v.count }
    item_counts.standard_deviation.round(2)
  end

  def items_per_merchant
    grouped_hash = @items.repository.group_by { |item| item.merchant_id }
    grouped_hash.map {|k,v| {k => v.count} }
  end

  def merchants_with_high_item_count
    st_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    high_count = (avg + st_dev).to_f.round(2)
    high_item_count_merchants = items_per_merchant.select { |pair| pair.values[0] > high_count }
    high_item_count_merchants.map { |pair| @merchants.find_by_id(pair.keys[0]) }
  end

  def average_item_price_for_merchant(id)
    specific_merchant_items = @items.repository.select { |item| item.merchant_id == id }
    num_specific_items = specific_merchant_items.count
    prices = specific_merchant_items.map { |item| item.unit_price }
    sum = prices.inject(0) { |prices_sum, price| prices_sum += price }
    if num_specific_items > 0
      result = BigDecimal(sum / num_specific_items)
      result.round(2)
    else BigDecimal(0, 4)
    end
  end

  def average_average_price_per_merchant
    merchant_averages = @merchants.repository.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    grouped_items = @items.repository.group_by {|item| item.merchant_id }
    grouped_items.map { |k, v| [k => v.count] }
    sum_avg_merch_prices = merchant_averages.inject(0) {|sum, average| sum += average}
    BigDecimal(sum_avg_merch_prices / @merchants.repository.count).round(2)
  end

  def average_item_price_finder
    sum = @item_prices_array.inject(0) { |summed_prices, item_price| summed_prices += item_price }
    BigDecimal(sum / @items.repository.count)
  end

  def item_price_standard_deviation
    avg_item_price = BigDecimal(average_item_price_finder, 2)
    differences = @item_prices_array.map do |price|
      price - avg_item_price
    end
    squares = differences.map { |num| num ** 2 }
    sum = squares.inject(0) { |summed_squares, squares| summed_squares += squares }
    st_dev = Math.sqrt(BigDecimal(sum, 4) / BigDecimal(@item_prices_array.count - 1))
    st_dev.round(2)
  end

  def golden_items
    st_dev_modified = BigDecimal((item_price_standard_deviation * 2), 4)
    average_item_price = average_item_price_finder
    @items.repository.select do |item|
      item.unit_price >= (average_item_price + st_dev_modified)
    end
  end

  def average_invoices_per_merchant
    num_invoices = @invoices.repository.count
    num_merchants = @merchants.repository.count
    avg = num_invoices.to_f / num_merchants.to_f
    avg.round(2)
  end

  def invoices_per_merchant
    grouped_hash = @invoices.repository.group_by { |invoice| invoice.merchant_id }
    grouped_hash.map {|_k,v| v.count}
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant.standard_deviation.round(2)
  end

  def top_merchants_by_invoice_count
    st_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    high_count = (avg + (st_dev * 2)).to_f.round(2)
    merchants_with_invoices.map { |k, v| k if v.count > high_count }.compact
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    @invoices.where_any(merchant_id, "merchant_id")
  end

  def merchants_with_invoices
    @merchants.repository.inject({}) do |merchant_invoices, merchant|
      merchant_invoices[merchant] = find_all_invoices_by_merchant_id(merchant.id)
      merchant_invoices
    end
  end

  def bottom_merchants_by_invoice_count
    st_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    low_count = ((((st_dev * 2) - avg).abs).to_f).round(2)
    merchants_with_invoices.map do |key, value|
      key if value.count < low_count
    end.compact
  end

  def top_days_by_invoice_count
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    invoice_day = @invoices.repository.map{ |invoice| invoice.created_at.strftime("%A") }
    days_count = days.map{ |day| [day, invoice_day.count(day)] }.to_h
    average = (days_count.inject(0) { |memo, (_k,v) | memo += v }.to_f / days_count.length.to_f).round(2)
    std_dev = days_count.values.standard_deviation
    days_count.select{ |day,count| count > average + std_dev }.keys
  end

  def invoice_status(status)
    matched_invoices = @invoices.repository.count do |invoice|
      invoice.status == status
    end
    ((matched_invoices / @invoices.repository.length.to_f ) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    it_exists = @transactions.repository.any? {|transaction| transaction.invoice_id == invoice_id}
    paid = @transactions.repository.find {|transaction| transaction.invoice_id == invoice_id}
    it_exists && paid.result == :success 
  end

  def invoice_total(invoice_id)
    costs = []
    it_exists = @transactions.repository.any? {|transaction| transaction.invoice_id == invoice_id}
    specific_invoice_items = @invoice_items.repository.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
    specific_invoice_items.each { |ii| costs << (ii.unit_price * BigDecimal(ii.quantity)) }
    costs.inject(0) {|summed_cost, cost| summed_cost += cost} if it_exists
  end
end
