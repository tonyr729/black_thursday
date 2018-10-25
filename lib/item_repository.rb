require_relative '../lib/bt_methods'

class ItemRepository
  include BTMethods
  attr_reader :repository

  def initialize(items)
    @repository = items
  end

  def self.create_items(items_data)
    item_list = items_data.map do |item_data|
      Item.new(item_data)
    end
    self.new(item_list)
  end

  def find_all_with_description(description)
    where_any(description, "description")
  end




end
