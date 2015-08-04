Item.find_or_create_by(title: 'Chips', description: 'Tasty chips with ketchup', price: 3.00)
Item.find_or_create_by(title: 'Baked chicken', description: 'Chicken baked in oven', price: 12.00)
Item.find_or_create_by(title: 'Tomato salad', description: 'Salad from tomatoes and onions', price: 5.70)
Item.find_or_create_by(title: 'Grilled sausage', description: 'Sausage from the grill', price: 4.75)
Item.find_or_create_by(title: 'Pizza with chicken', description: 'Delicious pizza with parts of chicken', price: 25.00)
Item.find_or_create_by(title: 'Tea', description: 'Black tea', price: 3.50)
Item.find_or_create_by(title: 'Coffee', description: 'Instant coffee', price: 4.00)
Item.find_or_create_by(title: 'Mineral water', description: 'Fresh mineral water', price: 2.50)
Item.find_or_create_by(title: 'Hot dog', description: 'Tasty hot dog with ketchup', price: 4.20)
Item.find_or_create_by(title: 'Hamburger', description: 'Delicious hamburger with extra meat', price: 5.60)
Item.find_or_create_by(title: 'Bigos', description: 'Cabbage with meat', price: 7.80)
Item.find_or_create_by(title: 'Pierogi ruskie', description: 'Potatoes and curd inside pie', price: 7.00)
Item.find_or_create_by(title: 'Apple pie', description: 'Apples with pie', price: 3.00)
Item.find_or_create_by(title: 'Ice creams', description: 'Cold chocolate ice creams', price: 1.90)
Item.find_or_create_by(title: 'Beer', description: 'Cold beer', price: 2.80)
Item.find_or_create_by(title: 'Vodka', description: 'Burn as hell', price: 18.00)
Item.find_or_create_by(title: 'Fried fish', description: 'Fish fried on a pan', price: 10.20)
Item.find_or_create_by(title: 'New potatoes', description: 'New and tasty potatoes', price: 5.40)
Item.find_or_create_by(title: 'Groats', description: 'Barley groats', price: 8.15)
Item.find_or_create_by!(title: 'Rice', description: 'White rice', price: 6.30)

User.create!(first_name: 'Rachel', last_name: 'Werbelow', email: 'demo+rachel@jumpstartlab.com', password: 'password')
User.create!(first_name: 'Jeff', last_name: 'Casimir', email: 'demo+jeff@jumpstartlab.com', password: 'password', display_name: 'j3')
User.create!(first_name: 'Jorge', last_name: 'Tellez', email: 'demo+jorge@jumpstartlab.com', password: 'password', display_name: 'novohispano')
User.create!(first_name: 'Josh', last_name: 'Cheek', email: 'demo+josh@jumpstartlab.com', password: 'password', display_name: 'josh', admin: true)
