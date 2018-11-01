require_relative 'test_helper.rb'
require 'bigdecimal'
require './lib/item'
require 'time'


class ItemTest < Minitest::Test
  def setup
    @data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
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
    expected = BigDecimal("1099", 4) / BigDecimal(100, 4)
    assert_equal expected, @item.unit_price
  end

  def test_it_has_created_at
    actual = @item.created_at.to_s
    expected = @data[:created_at].to_s
    assert_equal expected, actual
  end

  def test_it_has_updated_at
    actual = @item.updated_at.to_s
    expected = @data[:updated_at].to_s
    assert_equal expected, actual
  end

  def test_it_has_merchant_id
    assert_equal @data[:merchant_id], @item.merchant_id
  end

  def test_it_can_change_the_unit_price_to_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end




end
