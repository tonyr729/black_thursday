require_relative 'test_helper.rb'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal'

class ItemRepositoryTest < Minitest::Test
  def setup
    @data_1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "2500",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @data_2 = {
      :id          => 2,
      :name        => "Marker",
      :description => "It has ink",
      :unit_price  => "544",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    @items_data = [@data_1, @data_2]
    @item_1 = Item.new(@data_1)
    @ir = ItemRepository.new([@item_1])
    @item_repo = ItemRepository.create_items(@items_data)
  end


  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_holds_items
    assert_equal [@item_1], @ir.repository
  end

  def test_it_creates_items
    assert_instance_of Item, @item_repo.repository[0]
    assert_equal "Pencil", @item_repo.repository[0].name
    assert_instance_of Item, @item_repo.repository[1]
    assert_equal 3, @item_repo.repository[1].merchant_id
  end

  def test_it_returns_all_subclasses
    assert_equal [@item_1], @ir.all
  end

  def test_it_finds_by_id

    assert_nil @item_repo.find_by_id(4)
    assert_equal @item_repo.repository[1], @item_repo.find_by_id(2)
  end

  def test_it_finds_by_name

    assert_equal @item_repo.repository[1], @item_repo.find_by_name("Mark")
  end

  def test_it_finds_all_with_description

    assert_equal [], @item_repo.find_all_with_description("purple")
    assert_equal [@item_repo.repository[1]], @item_repo.find_all_with_description("ink")
  end

  def test_it_finds_all_by_price

    assert_equal [], @item_repo.find_all_by_price(4.50)
    assert_equal [@item_repo.repository[0]], @item_repo.find_all_by_price(BigDecimal(25))
  end

  def test_it_finds_all_by_range

    assert_equal [], @item_repo.find_all_by_price_in_range((1..3))
    assert_equal [@item_repo.repository[0]], @item_repo.find_all_by_price_in_range((20..30))
  end

  def test_it_finds_all_by_merchant_id

    assert_equal [], @item_repo.find_all_by_merchant_id(5)
    assert_equal [@item_repo.repository[1]], @item_repo.find_all_by_merchant_id(3)
  end

  def test_it_creates_new_ir_with_attributes
    actual = @item_repo.create({
      :name        => "Brioche Bun",
      :description => "Add coconut oil, then grill it",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 6
      }).last
    expected = @item_repo.repository.max_by { |x| x.id}
    assert_equal expected, actual
  end

  def test_it_updates_attributes
    expected = @item_repo.repository[1]
    assert_equal "Marker", expected.name
    actual = @item_repo.update(2, {name: "Cotton Candy",
      description: "It's pink",
      merchant_id: 48})
    assert_equal expected, actual
    assert_equal "Cotton Candy", expected.name
    assert_equal "It's pink", expected.description
    assert_equal 48, expected.merchant_id
  end

  def test_it_can_delete_an_id
    item_1 = @item_repo.repository[0]
    item_2 = @item_repo.repository[1]
    assert_equal [item_1, item_2], @item_repo.repository
    @item_repo.delete(2)
    assert_equal [item_1], @item_repo.repository
  end

end
