require 'pry'

class SalesAnalyst

  attr_reader :items, :merchants, :invoices

  def initialize (items, merchants, invoices)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @item_prices_array = @items.repository.map { |item| item.unit_price }
  end

  def average_items_per_merchant
    x = @items.repository.count / @merchants.repository.count.to_f
    x.round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids = @items.repository.map {|item| item.merchant_id}
    grouped_hash = merchant_ids.group_by {|id| id}
    number_of_items_per_merchant = grouped_hash.map {|k,v| v.count}
    squares = number_of_items_per_merchant.map do |num|
      x = (num - average_items_per_merchant) ** 2
      x.abs
    end
    summed_squares = squares.inject(0) { |sum, square| sum + square }
    st_dev = Math.sqrt(summed_squares / (squares.count - 1))
    st_dev.round(2)
  end

  def merchants_with_high_item_count
    st_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    high_count = (avg + st_dev).to_f.round(2)
    grouped_items = @items.repository.group_by {|item| item.merchant_id }
    merchant_item_count_hash = grouped_items.map { |k, v| [k => v.count] }
    stacked_merchants = merchant_item_count_hash.select { |pair| pair[0].values[0] > high_count }.flatten
    stacked_merchants.map do |pair|
      @merchants.repository.find do |merchant|
        merchant.id == pair.keys[0]
      end
    end
  end

  def average_item_price_for_merchant(id)
    specific_merchant_items = @items.repository.select { |item| item.merchant_id == id }
    num_specific_items = specific_merchant_items.count
    prices = specific_merchant_items.map { |item| item.unit_price }
    sum = prices.inject(0) { |memo, x| memo + x }
    result = BigDecimal(sum / num_specific_items)
    result.round(2)
  end

  def average_average_price_per_merchant
    array_1 = @merchants.repository.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    sum_avg_merch_prices = array_1.inject(0) { |sum, x| sum + x }
    result = BigDecimal(sum_avg_merch_prices / @merchants.repository.count)
    result.round(2)
  end

  def average_item_price_finder
    sum = @item_prices_array.inject(0) { |memo, x| memo + x }
    BigDecimal(sum / @items.repository.count)
  end

  def item_price_standard_deviation
    avg_item_price = BigDecimal(average_item_price_finder, 2)
    differences = @item_prices_array.map do |price|
      price - avg_item_price
    end
    squares = differences.map { |num| num ** 2 }
    summed_squares = squares.inject(0) { |memo, x| memo + x }
    a = BigDecimal(summed_squares, 4)
    b = BigDecimal(@item_prices_array.count - 1)
    st_dev = Math.sqrt( a / b )
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
    grouped_hash.map {|k,v| v.count}
  end

  def average_invoices_per_merchant_standard_deviation
    number_of_invoices_per_merchant = invoices_per_merchant
    squares = number_of_invoices_per_merchant.map do |num|
      x = (num - average_invoices_per_merchant) ** 2
      x.abs
    end
    summed_squares = squares.inject(0) { |sum, square| sum + square }
    st_dev = Math.sqrt(summed_squares / (squares.count - 1))
    st_dev.round(2)
  end

  def top_merchants_by_invoice_count
    #which merchants item count are more than 2 stdev above the average
    average = average_invoices_per_merchant
    st_dev = average_invoices_per_merchant_standard_deviation
    grouped_hash = @invoices.repository.group_by { |invoice| invoice.merchant_id }
    x = grouped_hash.select do |key, value|
      # {key => value.count}
      value.count >= average + (st_dev * 2)
    end
    binding.pry
  end

end
