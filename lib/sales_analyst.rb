
class SalesAnalyst

  attr_reader :items, :merchants

  def initialize (items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    @items.repository.count / @merchants.repository.count.to_f
  end

end
