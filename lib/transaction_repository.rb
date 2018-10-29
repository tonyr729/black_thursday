require_relative '../lib/bt_methods'
require 'time'

class TransactionRepository
  include BTMethods
  attr_reader :repository

  def initialize(transactions)
    @repository = transactions
    @new_instance = Transaction
  end

  def self.create_transactions(transactions_data)
    transaction_list = transactions_data.map do |transaction_data|
      Transaction.new(transaction_data)
    end
    self.new(transaction_list)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def find_all_by_result(result)
    where_any(result, "result")
  end

end
