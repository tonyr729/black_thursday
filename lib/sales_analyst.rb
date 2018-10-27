require_relative '../lib/sales_engine'


class SalesAnalyst < SalesEngine

  attr_reader :items, :merchants

  def initialize(merchants, items)
    super(merchants, items)
  end

  def average_items_per_merchant
    (@items.count / @merchants.count.to_f)
  end

end
