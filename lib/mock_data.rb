class MockData
  def items
    item_1  = Item.new({id: 1, name: "Golden Shovel", description: "A poetic book", unit_price: "4000000", created_at: Time.now, updated_at: Time.now, merchant_id: 25})
    item_2  = Item.new({id: 2, name: "Thundervest", description: "Interesting things", unit_price: "4000", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    item_3  = Item.new({id: 3, name: "Burger", description: "a", unit_price: "1002", created_at: Time.now, updated_at: Time.now, merchant_id: 35})
    item_4  = Item.new({id: 4, name: "Noodle", description: "b", unit_price: "1003", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    item_5  = Item.new({id: 5, name: "Hawt Dawg", description: "c", unit_price: "10054", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    item_6  = Item.new({id: 6, name: "Regular Hot Dog", description: "d", unit_price: "40094", created_at: Time.now, updated_at: Time.now, merchant_id: 45})
    item_7  = Item.new({id: 7, name: "Corn dog", description: "e", unit_price: "30098", created_at: Time.now, updated_at: Time.now, merchant_id: 55})
    item_8  = Item.new({id: 8, name: "Chicago dog", description: "f", unit_price: "40032", created_at: Time.now, updated_at: Time.now, merchant_id: 55})
    item_9  = Item.new({id: 9, name: "Tree", description: "g", unit_price: "400051", created_at: Time.now, updated_at: Time.now, merchant_id: 55})
    item_10 = Item.new({id: 10, name: "Mountain", description: "h", unit_price: "40002", created_at: Time.now, updated_at: Time.now, merchant_id: 55})
    item_11 = Item.new({id: 11, name: "Doctor Costume", description: "i", unit_price: "4007", created_at: Time.now, updated_at: Time.now, merchant_id: 65})
    item_12 = Item.new({id: 12, name: "Pumpkin", description: "j", unit_price: "5005", created_at: Time.now, updated_at: Time.now, merchant_id: 65})
    item_13 = Item.new({id: 13, name: "Grilled Chicken Breast", description: "i", unit_price: "500", created_at: Time.now, updated_at: Time.now, merchant_id: 65})
    item_14 = Item.new({id: 14, name: "$600 Noodles and Company Gift Card", description: "k", unit_price: "500", created_at: Time.now, updated_at: Time.now, merchant_id: 65})
    item_15 = Item.new({id: 15, name: "Mom's Beef Stroganoff", description: "yum", unit_price: "900801", created_at: Time.now, updated_at: Time.now, merchant_id: 65})
    item_16 = Item.new({id: 16, name: "Corn hog", description: "l", unit_price: "600", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_17 = Item.new({id: 17, name: "Burger in a blanket", description: "m", unit_price: "9009", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_18 = Item.new({id: 18, name: "TEMPUR-Flex® Supreme Breeze", description: "zzzzzzzzz", unit_price: "100", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_19 = Item.new({id: 19, name: "Bag o' ricardos", description: "z", unit_price: "60050", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_20 = Item.new({id: 20, name: "Funyuns", description: "rfghnm", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_21 = Item.new({id: 21, name: "Black beans", description: "treqtrt", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_22 = Item.new({id: 22, name: "Logitech Mouse", description: "bgrebgr", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_23 = Item.new({id: 23, name: "LG TV", description: "yes", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_24 = Item.new({id: 24, name: "Men's multivitamin", description: "grgb", unit_price: "300800", created_at: Time.now, updated_at: Time.now, merchant_id: 75})
    item_25 = Item.new({id: 25, name: "Grandma's Pumpkin Quick Bread", description: "x", unit_price: "2500", created_at: Time.now, updated_at: Time.now, merchant_id: 85})
    [item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8, item_9, item_10,
      item_11, item_12, item_13, item_14, item_15, item_16, item_17, item_18, item_19, item_20, item_21, item_22, item_23, item_24, item_25]
  end

  def merchants
    merchant_1 = Merchant.new({id: 25, name: "Useless Collectibles"})
    merchant_2 = Merchant.new({id: 35, name: "doganxiety.bacon"})
    merchant_3 = Merchant.new({id: 45, name: "nationalcorndogday.com"})
    merchant_4 = Merchant.new({id: 55, name: "Ok Collectibles"})
    merchant_5 = Merchant.new({id: 65, name: "catanxiety.fish"})
    merchant_6 = Merchant.new({id: 75, name: "lionsdontkillpeoplepeoplekillpeople.com"})
    merchant_7 = Merchant.new({id: 85, name: "Farva is Number One"})
    merchant_8 = Merchant.new({id: 95, name: "Nike"})
    [merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6, merchant_7, merchant_8]
  end

  def invoices
    invoice_1  = Invoice.new({:id => 1, :customer_id => 10, :merchant_id => 25, :status => :shipped, :created_at  => Time.parse("2018-04-02"), :updated_at  => Time.now})
    invoice_2  = Invoice.new({:id => 2, :customer_id => 9, :merchant_id => 35, :status => :shipped, :created_at  => Time.parse("2018-04-03"), :updated_at  => Time.now})
    invoice_2  = Invoice.new({:id => 2, :customer_id => 9, :merchant_id => 35, :status => :returned, :created_at  => Time.parse("2018-04-04"), :updated_at  => Time.now})
    invoice_2  = Invoice.new({:id => 2, :customer_id => 9, :merchant_id => 35, :status => :returned, :created_at  => Time.parse("2018-04-05"), :updated_at  => Time.now})
    invoice_3  = Invoice.new({:id => 3, :customer_id => 8, :merchant_id => 35, :status => :pending, :created_at  => Time.parse("2018-04-06"), :updated_at  => Time.now})
    invoice_4  = Invoice.new({:id => 4, :customer_id => 7, :merchant_id => 45, :status => :shipped, :created_at  => Time.parse("2018-04-07"), :updated_at  => Time.now})
    invoice_5  = Invoice.new({:id => 5, :customer_id => 6, :merchant_id => 45, :status => :shipped, :created_at  => Time.parse("2018-04-08"), :updated_at  => Time.now})
    invoice_6  = Invoice.new({:id => 6, :customer_id => 5, :merchant_id => 45, :status => :returned, :created_at  => Time.parse("2018-04-09"), :updated_at  => Time.now})
    invoice_7  = Invoice.new({:id => 7, :customer_id => 4, :merchant_id => 55, :status => :pending, :created_at  => Time.parse("2018-04-10"), :updated_at  => Time.now})
    invoice_8  = Invoice.new({:id => 8, :customer_id => 3, :merchant_id => 55, :status => :pending, :created_at  => Time.parse("2018-04-11"), :updated_at  => Time.now})
    invoice_9  = Invoice.new({:id => 9, :customer_id => 2, :merchant_id => 55, :status => :pending, :created_at  => Time.parse("2018-04-12"), :updated_at  => Time.now})
    invoice_10 = Invoice.new({:id => 10, :customer_id => 1, :merchant_id => 55, :status => :pending, :created_at  => Time.parse("2018-04-13"), :updated_at  => Time.now})
    invoice_11 = Invoice.new({:id => 11, :customer_id => 10, :merchant_id => 65, :status => :pending, :created_at  => Time.parse("2018-04-14"), :updated_at  => Time.now})
    invoice_12 = Invoice.new({:id => 12, :customer_id => 10, :merchant_id => 65, :status => :pending, :created_at  => Time.parse("2018-04-15"), :updated_at  => Time.now})
    invoice_13 = Invoice.new({:id => 13, :customer_id => 9, :merchant_id => 65, :status => :pending, :created_at  => Time.parse("2018-04-16"), :updated_at  => Time.now})
    invoice_14 = Invoice.new({:id => 14, :customer_id => 9, :merchant_id => 65, :status => :pending, :created_at  => Time.parse("2018-04-17"), :updated_at  => Time.now})
    invoice_15 = Invoice.new({:id => 15, :customer_id => 9, :merchant_id => 65, :status => :pending, :created_at  => Time.parse("2018-04-18"), :updated_at  => Time.now})
    invoice_16 = Invoice.new({:id => 16, :customer_id => 9, :merchant_id => 75, :status => :pending, :created_at  => Time.parse("2018-04-19"), :updated_at  => Time.now})
    invoice_17 = Invoice.new({:id => 17, :customer_id => 8, :merchant_id => 75, :status => :pending, :created_at  => Time.parse("2018-04-20"), :updated_at  => Time.now})
    invoice_18 = Invoice.new({:id => 18, :customer_id => 8, :merchant_id => 75, :status => :pending, :created_at  => Time.parse("2018-04-21"), :updated_at  => Time.now})
    invoice_19 = Invoice.new({:id => 19, :customer_id => 7, :merchant_id => 75, :status => :pending, :created_at  => Time.parse("2018-04-22"), :updated_at  => Time.now})
    invoice_20 = Invoice.new({:id => 20, :customer_id => 7, :merchant_id => 75, :status => :pending, :created_at  => Time.parse("2018-04-23"), :updated_at  => Time.now})
    invoice_21 = Invoice.new({:id => 21, :customer_id => 7, :merchant_id => 75, :status => :pending, :created_at  => Time.parse("2018-04-24"), :updated_at  => Time.now})
    invoice_22 = Invoice.new({:id => 22, :customer_id => 6, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-04-25"), :updated_at  => Time.now})
    invoice_23 = Invoice.new({:id => 23, :customer_id => 6, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-04-26"), :updated_at  => Time.now})
    invoice_24 = Invoice.new({:id => 24, :customer_id => 5, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-04-27"), :updated_at  => Time.now})
    invoice_25 = Invoice.new({:id => 25, :customer_id => 5, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-04-28"), :updated_at  => Time.now})
    invoice_26 = Invoice.new({:id => 25, :customer_id => 6, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-04-29"), :updated_at  => Time.now})
    invoice_27 = Invoice.new({:id => 25, :customer_id => 7, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-04-30"), :updated_at  => Time.now})
    invoice_28 = Invoice.new({:id => 25, :customer_id => 10, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-01"), :updated_at  => Time.now})
    invoice_29 = Invoice.new({:id => 25, :customer_id => 10, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-02"), :updated_at  => Time.now})
    invoice_30 = Invoice.new({:id => 25, :customer_id => 10, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-03"), :updated_at  => Time.now})
    invoice_31 = Invoice.new({:id => 25, :customer_id => 10, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-04"), :updated_at  => Time.now})
    invoice_32 = Invoice.new({:id => 25, :customer_id => 1, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-05"), :updated_at  => Time.now})
    invoice_33 = Invoice.new({:id => 25, :customer_id => 1, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-06"), :updated_at  => Time.now})
    invoice_34 = Invoice.new({:id => 25, :customer_id => 2, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-07"), :updated_at  => Time.now})
    invoice_35 = Invoice.new({:id => 25, :customer_id => 2, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-08"), :updated_at  => Time.now})
    invoice_36 = Invoice.new({:id => 25, :customer_id => 2, :merchant_id => 85, :status => :pending, :created_at  => Time.parse("2018-05-09"), :updated_at  => Time.now})
    [invoice_1, invoice_2, invoice_3, invoice_4, invoice_5, invoice_6, invoice_7, invoice_8, invoice_9, invoice_10,
      invoice_11, invoice_12, invoice_13, invoice_14, invoice_15, invoice_16, invoice_17, invoice_18, invoice_19, invoice_20,
      invoice_21, invoice_22, invoice_23, invoice_24, invoice_25, invoice_26, invoice_27, invoice_28, invoice_29, invoice_30,
      invoice_31, invoice_32, invoice_33, invoice_34, invoice_35, invoice_36]
  end


  def transactions
    transaction_1 = Transaction.new({:id => 1, :invoice_id => 1, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_2 = Transaction.new({:id => 2, :invoice_id => 2, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_3 = Transaction.new({:id => 3, :invoice_id => 3, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_4 = Transaction.new({:id => 4, :invoice_id => 4, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_5 = Transaction.new({:id => 5, :invoice_id => 5, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_6 = Transaction.new({:id => 6, :invoice_id => 6, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_7 = Transaction.new({:id => 7, :invoice_id => 7, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_8 = Transaction.new({:id => 8, :invoice_id => 8, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_9 = Transaction.new({:id => 9, :invoice_id => 9, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_10 = Transaction.new({:id => 10, :invoice_id => 10, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    transaction_11 = Transaction.new({:id => 11, :invoice_id => 10, :credit_card_number => "4242424242424242", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    [transaction_1, transaction_2, transaction_3, transaction_4, transaction_5, transaction_6, transaction_7, transaction_8, transaction_9, transaction_10, transaction_11]
  end

  def customers
    customer_1 = Customer.new({:id => 1, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now})
    customer_2 = Customer.new({:id => 2, :first_name => "Michael", :last_name => "Clampett", :created_at => Time.now, :updated_at => Time.now})
    customer_3 = Customer.new({:id => 3, :first_name => "Tony", :last_name => "Robertson", :created_at => Time.now, :updated_at => Time.now})
    customer_4 = Customer.new({:id => 4, :first_name => "Shawnee", :last_name => "Adelson", :created_at => Time.now, :updated_at => Time.now})
    customer_5 = Customer.new({:id => 5, :first_name => "Chris", :last_name => "DAmico", :created_at => Time.now, :updated_at => Time.now})
    customer_6 = Customer.new({:id => 6, :first_name => "Serena", :last_name => "Curry", :created_at => Time.now, :updated_at => Time.now})
    customer_7 = Customer.new({:id => 7, :first_name => "Sarah", :last_name => "Lane", :created_at => Time.now, :updated_at => Time.now})
    customer_8 = Customer.new({:id => 8, :first_name => "Megan", :last_name => "Guzowski", :created_at => Time.now, :updated_at => Time.now})
    customer_9 = Customer.new({:id => 9, :first_name => "Lucretia", :last_name => "Keenan", :created_at => Time.now, :updated_at => Time.now})
    customer_10 = Customer.new({:id => 10, :first_name => "Kelly", :last_name => "Broadbear", :created_at => Time.now, :updated_at => Time.now})
    customer_11 = Customer.new({:id => 11, :first_name => "Maria", :last_name => "Kogle", :created_at => Time.now, :updated_at => Time.now})
    customer_12 = Customer.new({:id => 12, :first_name => "Andy", :last_name => "Busold", :created_at => Time.now, :updated_at => Time.now})
    customer_13 = Customer.new({:id => 13, :first_name => "Johnny", :last_name => "Flowers", :created_at => Time.now, :updated_at => Time.now})
    customer_14 = Customer.new({:id => 14, :first_name => "Hunter", :last_name => "Grondin", :created_at => Time.now, :updated_at => Time.now})
    customer_15 = Customer.new({:id => 15, :first_name => "Sydney", :last_name => "Skilken", :created_at => Time.now, :updated_at => Time.now})
    customer_16 = Customer.new({:id => 16, :first_name => "Krissy", :last_name => "Held", :created_at => Time.now, :updated_at => Time.now})
    customer_17 = Customer.new({:id => 17, :first_name => "Jonesy", :last_name => "Wilcox", :created_at => Time.now, :updated_at => Time.now})
    customer_18 = Customer.new({:id => 18, :first_name => "Sarah", :last_name => "Studebaker", :created_at => Time.now, :updated_at => Time.now})
    customer_19 = Customer.new({:id => 19, :first_name => "Dave", :last_name => "Yob", :created_at => Time.now, :updated_at => Time.now})
    customer_20 = Customer.new({:id => 20, :first_name => "Tristan", :last_name => "Chan", :created_at => Time.now, :updated_at => Time.now})
    [customer_1, customer_2, customer_3, customer_4, customer_5, customer_6, customer_7, customer_8, customer_9, customer_10, customer_11, customer_12,
    customer_13, customer_14, customer_15, customer_16, customer_17, customer_18, customer_19, customer_20]
  end


end
