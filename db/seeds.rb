c1 = Category.find_or_create_by!(name: 'Drinks')
c2 = Category.find_or_create_by!(name: 'Vegetables')
c3 = Category.find_or_create_by!(name: 'Meat')
c4 = Category.find_or_create_by!(name: 'Fast food')
c5 = Category.find_or_create_by!(name: 'Deserts')
c6 = Category.find_or_create_by!(name: 'No meat')
c7 = Category.find_or_create_by!(name: 'Fishes')


Item.find_or_create_by!(title: 'Chips') do |item|
  item.description = 'Tasty chips with ketchup'
  item.price = 3.00
  item.categories << c4
end
Item.find_or_create_by!(title: 'Baked chicken') do |item|
  item.description = 'Chicken baked in oven'
  item.price = 12.00
  item.categories << c3
end
Item.find_or_create_by!(title: 'Tomato salad') do |item|
  item.description = 'Salad from tomatoes and onions'
  item.price = 5.70
  item.categories << c2
end
Item.find_or_create_by!(title: 'Grilled sausage') do |item|
  item.description = 'Sausage from the grill'
  item.price = 4.75
  item.categories << c3 << c4
end
Item.find_or_create_by!(title: 'Pizza with chicken') do |item|
  item.description = 'Delicious pizza with parts of chicken'
  item.price = 25.00
  item.categories << c3 << c4
end
Item.find_or_create_by!(title: 'Tea') do |item|
  item.description = 'Black tea'
  item.price = 3.50
  item.categories << c1
end
Item.find_or_create_by!(title: 'Coffee') do |item|
  item.description = 'Instant coffee'
  item.price = 4.00
  item.categories << c1
end
Item.find_or_create_by!(title: 'Mineral water') do |item|
  item.description = 'Fresh mineral water'
  item.price = 2.50
  item.categories << c1
end
Item.find_or_create_by!(title: 'Hot dog') do |item|
  item.description = 'Tasty hot dog with ketchup'
  item.price = 4.20
  item.categories << c3 << c4
end
Item.find_or_create_by!(title: 'Hamburger') do |item|
  item.description = 'Delicious hamburger with extra meat'
  item.price = 5.60
  item.categories << c3 << c4
end
Item.find_or_create_by!(title: 'Bigos') do |item|
  item.description = 'Cabbage with meat'
  item.price = 7.80
  item.categories << c2 << c3
end
Item.find_or_create_by!(title: 'Pierogi ruskie') do |item|
  item.description = 'Potatoes and curd inside pie'
  item.price = 7.00
  item.categories << c6
end
Item.find_or_create_by!(title: 'Apple pie') do |item|
  item.description = 'Apples with pie'
  item.price = 3.00
  item.categories << c5
end
Item.find_or_create_by!(title: 'Ice creams') do |item|
  item.description = 'Cold chocolate ice creams'
  item.price = 1.90
  item.categories << c5
end
Item.find_or_create_by!(title: 'Beer') do |item|
  item.description = 'Cold beer'
  item.price = 2.80
  item.categories << c1
end
Item.find_or_create_by!(title: 'Vodka') do |item|
  item.description = 'Burn as hell'
  item.price = 18.00
  item.categories << c1
end
Item.find_or_create_by!(title: 'Fried fish') do |item|
  item.description = 'Fish fried on a pan'
  item.price = 10.20
  item.categories << c7
end
Item.find_or_create_by!(title: 'New potatoes') do |item|
  item.description = 'New and tasty potatoes'
  item.price = 5.40
  item.categories << c2
end
Item.find_or_create_by!(title: 'Groats') do |item|
  item.description = 'Barley groats'
  item.price = 8.15
  item.categories << c6
end
Item.find_or_create_by!(title: 'Rice') do |item|
  item.description = 'White rice'
  item.price = 6.30
  item.categories << c6
end

User.where(email: 'demo+rachel@jumpstartlab.com').first_or_create!(first_name: 'Rachel', last_name: 'Werbelow', password: 'password')
User.where(email: 'demo+jeff@jumpstartlab.com').first_or_create!(first_name: 'Jeff', last_name: 'Casimir', password: 'password', display_name: 'j3')
User.where(email: 'demo+jorge@jumpstartlab.com').first_or_create!(first_name: 'Jorge', last_name: 'Tellez', password: 'password', display_name: 'novohispano')
User.where(email: 'demo+josh@jumpstartlab.com').first_or_create!(first_name: 'Josh', last_name: 'Cheek', password: 'password', display_name: 'josh', admin: true)

statuses = %w[ordered paid completed cancelled]
10.times do |o|
  cart = Cart.new
  (rand(6) + 1).times do |oi|
    id = rand(20) + 1
    cart.add_item(id)
  end
  order = Order.new
  order.status = statuses[o%4]
  order.user_id = rand(3) + 1
  order.copy_items_from_cart(cart)
  order.save!
end
