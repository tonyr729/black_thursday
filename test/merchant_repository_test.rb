require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_1 = Merchant.new({:id=>5, :name=>"Nixon"})
    @mr = MerchantRepository.new([@merchant_1])
    @incoming_data =[
      {:id => 1, :name => "Tony", :updated => 2014},
      {:id => 2, :name => "Ali", :updated => 2014},
      {:id => 3, :name => "Michael", :updated => 2014}
    ]
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_holds_merchants
    assert_equal [@merchant_1], @mr.repository
  end

  def test_it_creates_merchants
    mr = MerchantRepository.create_merchants(@incoming_data)
    assert_instance_of Merchant, mr.repository[0]
    assert_equal "Tony", mr.repository[0].name
    assert_instance_of Merchant, mr.repository[1]
    assert_equal "Ali", mr.repository[1].name
    assert_instance_of Merchant, mr.repository[2]
    assert_equal "Michael", mr.repository[2].name
  end

  def test_it_finds_all_subclasses
    assert_equal [@merchant_1], @mr.all
  end

  def test_it_finds_by_id
    mr = MerchantRepository.create_merchants(@incoming_data)
    assert_nil mr.find_by_id(6)
    assert_equal mr.repository[1], mr.find_by_id(2)
  end

  def test_it_finds_by_name
    mr = MerchantRepository.create_merchants(@incoming_data)
    assert_equal mr.repository[2], mr.find_by_name("Michael")
  end

  def test_it_finds_all_by_name
    mr = MerchantRepository.create_merchants(@incoming_data)
    assert_equal [], mr.find_all_by_name("Bob")
    assert_equal [mr.repository[2]], mr.find_all_by_name("Michael")
  end

  def test_it_creates_a_new_mr_with_attributes
    mr = MerchantRepository.create_merchants(@incoming_data)
    actual = mr.create({name: "Steve"}).last
    expected = mr.repository.max_by { |x| x.id}
    assert_equal expected, actual
  end

  def test_it_updates_attributes
    mr = MerchantRepository.create_merchants(@incoming_data)
    expected = mr.repository[2]
    assert_equal "Michael", expected.name
    actual = mr.update(3, :name => "George")
    assert_equal expected, actual
    assert_equal "George", expected.name
  end

  def test_it_can_delete_an_id
    mr = MerchantRepository.create_merchants(@incoming_data)
    merchant_1 = mr.repository[0]
    merchant_3 = mr.repository[2]
    assert_equal [merchant_1, merchant_3], mr.delete(2)
  end

end
