require_relative 'test_helper.rb'
require 'pry'
require 'bigdecimal'
require './lib/item'


class ItemTest < Minitest::Test
  def setup
    @data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @item = Item.new(@data)
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_id
    assert_equal @data[:id], @item.id
  end

  def test_it_has_name
    assert_equal @data[:name], @item.name
  end

  def test_it_has_description
    assert_equal @data[:description], @item.description
  end

  def test_it_has_unit_price
    assert_equal @data[:unit_price], @item.unit_price
  end

  def test_it_has_created_at
    assert_equal @data[:created_at], @item.created_at
  end

  def test_it_has_updated_at
    assert_equal @data[:updated_at], @item.updated_at
  end

  def test_it_has_merchant_id
    assert_equal @data[:merchant_id], @item.merchant_id
  end



end
