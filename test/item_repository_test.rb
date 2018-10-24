require_relative 'test_helper.rb'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal'
require 'pry'


class ItemRepositoryTest < Minitest::Test

  def setup
    @data_1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @item_1 = Item.new(@data_1)
    @ir = ItemRepository.new([@item_1])
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_holds_items
    assert_equal [@item_1], @ir.items
  end

  def test_it_creates_items
    @data_2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "It has ink",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    items_data = [@data_1, @data_2]
    ir = ItemRepository.create_items(items_data)

    assert_instance_of Item, ir.items[0]
    assert_equal "Pencil", ir.items[0].name
    assert_instance_of Item, ir.items[1]
    assert_equal 3, ir.items[1].merchant_id
  end








end
