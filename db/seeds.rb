puts 'Cleaning database...'
Review.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all
puts 'Creating products...'

p = Product.create!(price: 1, description: "For when life gives you lemons. This zesty lemon tincture has a refreshing twist that we are sure you will enjoy.", name: 'Lemon', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431749/t8dqz9exgaseh2fkmw0v.jpg"))
Product.create!(price: 3, description: "Savour our smooth tasting orange flavour reminiscent of a freshly squeezed glass of OJ. ", name: 'Orange', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431749/t8dqz9exgaseh2fkmw0v.jpg"))
Product.create!(price: 2, description: "For those with a sweet tooth. Indulge in our chocolate tincture, one of the first on the market that we are sure you will enjoy.", name: 'Chocolate', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431749/t8dqz9exgaseh2fkmw0v.jpg"))
Product.create!(price: 1, description: "Our Pure tincture is a flavourless oil. Pure oil can be taken on its own or used in cooking, smoothies and protein shakes allowing you to get the benefits of CBD in your daily diet.", name: 'Pure', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431749/t8dqz9exgaseh2fkmw0v.jpg"))
Product.create!(price: 3, description: "A very popular flavour our mint tincture is cool and invigorating without being overpowering.", name: 'Mint', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431749/t8dqz9exgaseh2fkmw0v.jpg"))


user = User.create!(email: "admin@admin.com", admin: true, password: "123123", first_name: "Dominic", last_name: "Day", photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431269/lsseq4xw3walhbzdovf3.jpg"))
puts 'Creating Reviews...'

Review.create!(product_id: p.id, user_id: user.id, rating: 5, content: "This had miraculous healing effects upon my back pain.")
Review.create!(product_id: p.id, user_id: user.id, rating: 4, content: "This had miraculous healing effects upon my back pain.")
Review.create!(product_id: p.id, user_id: user.id, rating: 4, content: "This had miraculous healing effects upon my back pain.")
Review.create!(product_id: p.id, user_id: user.id, rating: 4, content: "This had miraculous healing effects upon my back pain.")
Review.create!(product_id: p.id, user_id: user.id, rating: 5, content: "This had miraculous healing effects upon my back pain.")
Review.create!(product_id: p.id, user_id: user.id, rating: 5, content: "This had miraculous healing effects upon my back pain.")

puts 'Finished!'
