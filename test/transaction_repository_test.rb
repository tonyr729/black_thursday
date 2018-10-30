require_relative 'test_helper.rb'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @data_1 = {
      :id => 1,
      :invoice_id => 2179,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration_date => "0217",
      :result => "success",
      :created_at => Time.parse("2012-02-26"),
      :updated_at => Time.now,
    }
    @data_2 = {
      :id => 2,
      :invoice_id => 46,
      :credit_card_number => 4177816490204479,
      :credit_card_expiration_date => "0813",
      :result => "success",
      :created_at => Time.parse("2016-06-19"),
      :updated_at => Time.now,
    }
    @transactions_data = [@data_1, @data_2]
    @transactions = TransactionRepository.create_transactions(@transactions_data)
    @tr = TransactionRepository.new([@transactions])
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_it_holds_transactions
    assert_equal [@transactions], @tr.repository
  end

  def test_it_creates_transactions
    assert_instance_of Transaction, @transactions.repository[0]
    assert_equal 1, @transactions.repository[0].id
    assert_instance_of Transaction, @transactions.repository[1]
    assert_equal "4177816490204479", @transactions.repository[1].credit_card_number
  end

  def test_it_returns_all_subclasses
    actual = @transactions.all
    assert_instance_of Transaction, actual[0]
    assert_equal 2, actual.length
  end

    def test_it_finds_by_id
      assert_nil @transactions.find_by_id(4)
      assert_equal @transactions.repository[1], @transactions.find_by_id(2)
    end

    def test_it_finds_all_by_invoice_id
      assert_equal [], @transactions.find_all_by_invoice_id(500)
      assert_equal [@transactions.repository[1]], @transactions.find_all_by_invoice_id(46)
    end

    def test_it_finds_all_by_credit_card_number
      assert_equal [], @transactions.find_all_by_credit_card_number(500)
      assert_equal [@transactions.repository[1]], @transactions.find_all_by_credit_card_number(4177816490204479)
    end

    def test_it_finds_all_by_results
      assert_equal [], @transactions.find_all_by_result("burger")
      assert_equal [@transactions.repository[0], @transactions.repository[1]], @transactions.find_all_by_result("success")
    end

end
