require 'pry'

class SalesAnalyst

  attr_reader :items, :merchants

  def initialize (items, merchants)
    @items = items
    @merchants = merchants
    @item_prices_array = @items.repository.map { |item| item.unit_price }
  end

  def average_items_per_merchant
    x = @items.repository.count / @merchants.repository.count.to_f
    x.round(2)
  end

  def average_items_per_merchant_standard_deviation
    sorted_items = @items.repository.sort_by {|item| item.merchant_id}
    merchant_ids = sorted_items.map {|item| item.merchant_id}
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
    mr = @merchants.repository
    mr.select do |merchant|
      matches = @items.repository.select do |item|
        item.merchant_id == merchant.id
      end
      matches.length >= (st_dev * 2)
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
    sum = @item_prices_array.inject(0) { |sum, x| sum + x }
    BigDecimal(sum / @items.repository.count)
  end

  def item_price_standard_deviation
    differences = @item_prices_array.map do |price|
      price - BigDecimal(average_item_price_finder, 2)
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


end
