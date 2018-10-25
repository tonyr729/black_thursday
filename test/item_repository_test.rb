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
    @data_2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "It has ink",
      :unit_price  => BigDecimal.new(5.44,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    @items_data = [@data_1, @data_2]
    @item_1 = Item.new(@data_1)
    @ir = ItemRepository.new([@item_1])
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_holds_items
    assert_equal [@item_1], @ir.repository
  end

  def test_it_creates_items
    ir = ItemRepository.create_items(@items_data)

    assert_instance_of Item, ir.repository[0]
    assert_equal "Pencil", ir.repository[0].name
    assert_instance_of Item, ir.repository[1]
    assert_equal 3, ir.repository[1].merchant_id
  end

  def test_it_returns_all_subclasses
    assert_equal [@item_1], @ir.all
  end

  def test_it_finds_by_id
    ir = ItemRepository.create_items(@items_data)
 
    assert_nil ir.find_by_id(4)
    assert_equal ir.repository[1], ir.find_by_id(2)
  end
  
  def test_it_finds_by_name
    ir = ItemRepository.create_items(@items_data)
    
    assert_equal ir.repository[1], ir.find_by_name("Pen")
  end
  
  def test_it_finds_all_with_description
    ir = ItemRepository.create_items(@items_data)
    
    assert_equal [], ir.find_all_with_description("purple")
    assert_equal [ir.repository[1]], ir.find_all_with_description("ink")
  end

  def test_it_finds_all_by_price
    ir = ItemRepository.create_items(@items_data)
    
    assert_equal [], ir.find_all_by_price(4.50)
    assert_equal [ir.repository[0]], ir.find_all_by_price(10.99)
  end
  
  def test_it_finds_all_by_range
    ir = ItemRepository.create_items(@items_data)
    
    assert_equal [], ir.find_all_by_price_in_range((1..3))
    assert_equal [ir.repository[0]], ir.find_all_by_price_in_range((8..15))
  end
  
  def test_it_finds_all_by_merchant_id
    ir = ItemRepository.create_items(@items_data)
    
    assert_equal [], ir.find_all_by_merchant_id(5)
    assert_equal [ir.repository[1]], ir.find_all_by_merchant_id(3)
  end
  
  def test_it_creates_new_ir_with_attributes
    ir = ItemRepository.create_items(@items_data)
    actual = ir.create({
      :name        => "Brioche Bun",
      :description => "Add coconut oil, then grill it",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 6
      }).last
    expected = ir.repository.max_by { |x| x.id}
    assert_equal expected, actual
  end

  def test_it_updates_attributes
    ir = ItemRepository.create_items(@items_data)
    expected = ir.repository[1]
    assert_equal "Pen", expected.name
    actual = ir.update(2, {name: "Cotton Candy",
      description: "It's pink",
      merchant_id: 48})
    assert_equal expected, actual
    assert_equal "Cotton Candy", expected.name
    assert_equal "It's pink", expected.description
    assert_equal 48, expected.merchant_id
  end

  def test_it_can_delete_an_id
    ir = ItemRepository.create_items(@items_data)
    item_1 = ir.repository[0]
    item_2 = ir.repository[1]
    assert_equal [item_1], ir.delete(2)
  end

end
