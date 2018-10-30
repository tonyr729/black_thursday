require_relative 'test_helper.rb'
require_relative '../lib/transaction'
require 'time'
require 'pry'

class TransactionTest < Minitest::Test
  # id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
  # 1,2179,4068631943231473,0217,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
  def setup
    @transaction = Transaction.new({
      :id => 1,
      :invoice_id => 2179,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration_date => "0217",
      :result => "success",
      :created_at => Time.parse("2012-02-26"),
      :updated_at => Time.now,
    })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_an_id
    assert_equal 1, @transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal 2179, @transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal "4068631943231473", @transaction.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal "0217", @transaction.credit_card_expiration_date
  end

  def test_it_has_a_result
    assert_equal :success, @transaction.result
  end

  def test_it_has_created_at
    actual = @transaction.created_at.to_s
    expected = Time.parse("2012-02-26").to_s
    assert_equal expected, actual
  end

  def test_it_has_updated_at
    actual = @transaction.updated_at.to_s
    expected = Time.now.to_s
    assert_equal expected, actual
  end
end
