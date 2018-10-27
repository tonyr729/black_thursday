require 'pry'

class SalesAnalyst

  attr_reader :items, :merchants

  def initialize (items, merchants)
    @items = items
    @merchants = merchants
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
    square = number_of_items_per_merchant.map do |num|
      x = (num - average_items_per_merchant) ** 2
      x.abs
    end
    summed_squares = square.inject(0) { |sum, x| sum + x }
    st_dev = Math.sqrt(summed_squares / (square.count - 1))
    st_dev.round(2)
  end

  def merchants_with_high_item_count
    st_dev = average_items_per_merchant_standard_deviation
    mr = @merchants.repository
    mr.select do |merchant|
      matches = @items.repository.select do |item|
        item.merchant_id == merchant.id
      end
      matches.count > (st_dev + 1 + average_items_per_merchant)
    end
  end

end
