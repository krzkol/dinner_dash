c1 = Category.find_or_create_by(name: 'Drinks')
c2 = Category.find_or_create_by(name: 'Vegetables')
c3 = Category.find_or_create_by(name: 'Meat')
c4 = Category.find_or_create_by(name: 'Fast food')
c5 = Category.find_or_create_by(name: 'Deserts')
c6 = Category.find_or_create_by(name: 'No meat')
c7 = Category.find_or_create_by(name: 'Fishes')


item = Item.find_or_create_by(title: 'Chips', description: 'Tasty chips with ketchup', price: 3.00)
item.categories = [c4]
item = Item.find_or_create_by(title: 'Baked chicken', description: 'Chicken baked in oven', price: 12.00)
item.categories = [c3]
item = Item.find_or_create_by(title: 'Tomato salad', description: 'Salad from tomatoes and onions', price: 5.70)
item.categories = [c2]
item = Item.find_or_create_by(title: 'Grilled sausage', description: 'Sausage from the grill', price: 4.75)
item.categories = [c3, c4]
item = Item.find_or_create_by(title: 'Pizza with chicken', description: 'Delicious pizza with parts of chicken', price: 25.00)
item.categories = [c3, c4]
item = Item.find_or_create_by(title: 'Tea', description: 'Black tea', price: 3.50)
item.categories = [c1]
item = Item.find_or_create_by(title: 'Coffee', description: 'Instant coffee', price: 4.00)
item.categories = [c1]
item = Item.find_or_create_by(title: 'Mineral water', description: 'Fresh mineral water', price: 2.50)
item.categories = [c1]
item = Item.find_or_create_by(title: 'Hot dog', description: 'Tasty hot dog with ketchup', price: 4.20)
item.categories = [c3, c4]
item = Item.find_or_create_by(title: 'Hamburger', description: 'Delicious hamburger with extra meat', price: 5.60)
item.categories = [c3, c4]
item = Item.find_or_create_by(title: 'Bigos', description: 'Cabbage with meat', price: 7.80)
item.categories = [c2, c3]
item = Item.find_or_create_by(title: 'Pierogi ruskie', description: 'Potatoes and curd inside pie', price: 7.00)
item.categories = [c6]
item = Item.find_or_create_by(title: 'Apple pie', description: 'Apples with pie', price: 3.00)
item.categories = [c5]
item = Item.find_or_create_by(title: 'Ice creams', description: 'Cold chocolate ice creams', price: 1.90)
item.categories = [c5]
item = Item.find_or_create_by(title: 'Beer', description: 'Cold beer', price: 2.80)
item.categories = [c1]
item = Item.find_or_create_by(title: 'Vodka', description: 'Burn as hell', price: 18.00)
item.categories = [c1]
item = Item.find_or_create_by(title: 'Fried fish', description: 'Fish fried on a pan', price: 10.20)
item.categories = [c7]
item = Item.find_or_create_by(title: 'New potatoes', description: 'New and tasty potatoes', price: 5.40)
item.categories = [c2]
item = Item.find_or_create_by(title: 'Groats', description: 'Barley groats', price: 8.15)
item.categories = [c6]
item = Item.find_or_create_by(title: 'Rice', description: 'White rice', price: 6.30)
item.categories = [c6]

User.where(email: 'demo+rachel@jumpstartlab.com').first_or_create(first_name: 'Rachel', last_name: 'Werbelow', password: 'password')
User.where(email: 'demo+jeff@jumpstartlab.com').first_or_create(first_name: 'Jeff', last_name: 'Casimir', password: 'password', display_name: 'j3')
User.where(email: 'demo+jorge@jumpstartlab.com').first_or_create(first_name: 'Jorge', last_name: 'Tellez', password: 'password', display_name: 'novohispano')
User.where(email: 'demo+josh@jumpstartlab.com').first_or_create(first_name: 'Josh', last_name: 'Cheek', password: 'password', display_name: 'josh', admin: true)

statuses = %w[ordered paid completed cancelled]
10.times do |o|
  order = Order.new(status: statuses[o % 4])
  (rand(3) + 1).times do |oi|
    id = rand(20) + 1
    qty = rand(20) + 1
    order.order_items.build(item_id: id, quantity: qty, price: Item.find(id).price, item_group: order)
    order.user_id = rand(3) + 1
  end
  order.save!
end
