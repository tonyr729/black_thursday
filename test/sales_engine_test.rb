require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @data = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    @se = SalesEngine.from_csv(@data)
  end

  def test_it_can_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_parses_csv_data
    expected = [
      {
        :id=>"12334105",
        :name=>"Shopin1901",
        :created_at=>"2010-12-10",
        :updated_at=>"2011-12-04"
      },
      {
        :id=>"12334112",
        :name=>"Candisart",
        :created_at=>"2009-05-30",
        :updated_at=>"2010-08-29"
      },
      {
        :id=>"12334113",
        :name=>"MiniatureBikez",
        :created_at=>"2010-03-30",
        :updated_at=>"2013-01-21"
      }
    ]

    assert_equal expected, @se.csv_parser("./data/mock_data.csv")
  end

  def test_it_can_create_a_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants_factory("./data/merchants.csv")
  end

  def test_it_can_create_an_item_repository
    assert_instance_of ItemRepository, @se.items_factory("./data/items.csv")
  end

  def test_it_can_create_an_invoice_repository
    assert_instance_of InvoiceRepository, @se.invoice_factory("./data/invoices.csv")
  end

  def test_it_can_create_an_invoice_item_repository
    assert_instance_of InvoiceItemRepository, @se.invoice_items_factory("./data/invoice_items.csv")
  end

  def test_it_can_create_a_transaction_repository
    assert_instance_of TransactionRepository, @se.transactions_factory("./data/transactions.csv")
  end

  def test_it_can_create_a_customer
    assert_instance_of CustomerRepository, @se.customer_factory("./data/customers.csv")
  end

  def test_it_has_analyst
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
