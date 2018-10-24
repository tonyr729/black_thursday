class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def self.create_items(items_data)
    item_list = items_data.map do |item_data|
      Item.new(item_data)
    end
    self.new(item_list)
  end





end
