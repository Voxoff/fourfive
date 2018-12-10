puts 'Cleaning database...'
Review.destroy_all
Strength.destroy_all
Product.destroy_all
User.destroy_all
puts 'Creating products...'

p = Product.create!(name: 'cbd oils', subtitle: "Flavored oils for quick absorption", price: 1, description: "For when life gives you lemons. This zesty lemon tincture has a refreshing twist that we are sure you will enjoy.", photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543755363/pqje5y6qblpza9f4cxdn.jpg"))
Product.create!(name: 'cbd capsules', price: 3, subtitle: "Easy-to-take capsules for slower release", description: "A very popular flavour our mint tincture is cool and invigorating without being overpowering. ", photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543755363/pqje5y6qblpza9f4cxdn.jpg"))
Product.create!(name: 'cbd balms', price: 2, subtitle: "Organic balms for damaged skin", description: "For those with a sweet tooth. Indulge in our chocolate tincture, one of the first on the market that we are sure you will enjoy.", photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543755363/pqje5y6qblpza9f4cxdn.jpg"))
# Product.create!(price: 1, description: "Our Pure tincture is a flavourless oil. Pure oil can be taken on its own or used in cooking, smoothies and protein shakes allowing you to get the benefits of cbd in your daily diet.", name: 'Pure', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543755363/pqje5y6qblpza9f4cxdn.jpg"))
# Product.create!(price: 3, description: "A very popular flavour our mint tincture is cool and invigorating without being overpowering.", name: 'Mint', photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543755363/pqje5y6qblpza9f4cxdn.jpg"))


user = User.create!(email: "admin@admin.com", admin: true, password: "123123", first_name: "Dominic", last_name: "Day", photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431269/lsseq4xw3walhbzdovf3.jpg"))
puts 'Creating Reviews...'

photo = open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543757174/eb8bk1ntavsaotcdmui0.png")

Review.create!(photo: photo, product_id: p.id, user_id: user.id, name: "Tom", position: "PE Teacher", content: "Help with sleep pattern ")
Review.create!(photo: photo, product_id: p.id, user_id: user.id, name: "Nathan Trowbridge", position: "Semi Pro rugby player", content: "Concussion")
Review.create!(photo: photo, product_id: p.id, user_id: user.id, name: "Chris Dicomidis", position: "International rugby player", content: "Recovery from knee ligament injury")

# Strength.create(strength: 100)
# Strength.create(strength: 500)
# Strength.create(strength: 1000)

# Product.all.each do |product|
#   Strength.all.each do |strength|
#     ProductStrength.create!(product: product, strength: strength)
#   end
# end
Product.find(1).update(name: 'cbd oils', subtitle: "Flavored oils for quick absorption")
Product.find(2).update(name: 'cbd balms', subtitle: "Organic balms for damaged skin")
Product.find(3).update(name: 'cbd capsules', subtitle: "Easy-to-take capsules for slower release")
puts 'Finished!'
