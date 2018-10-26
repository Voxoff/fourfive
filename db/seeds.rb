puts 'Cleaning database...'
Review.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all
puts 'Creating products...'

p = Product.create!(price: 1, description: "For when life gives you lemons. This zesty lemon tincture has a refreshing twist that we are sure you will enjoy.", name: 'Lemon', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 3, description: "Savour our smooth tasting orange flavour reminiscent of a freshly squeezed glass of OJ. ", name: 'Orange', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 2, description: "For those with a sweet tooth. Indulge in our chocolate tincture, one of the first on the market that we are sure you will enjoy.", name: 'Chocolate', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 1, description: "Our Pure tincture is a flavourless oil. Pure oil can be taken on its own or used in cooking, smoothies and protein shakes allowing you to get the benefits of CBD in your daily diet.", name: 'Pure', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 3, description: "A very popular flavour our mint tincture is cool and invigorating without being overpowering.", name: 'Mint', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')


user = User.create!(email: "admin@admin.com", password: "123123")
puts 'Creating Reviews...'

Review.create!(product_id: p.id, user_id: user.id, rating: 5)
Review.create!(product_id: p.id, user_id: user.id, rating: 4)
Review.create!(product_id: p.id, user_id: user.id, rating: 4)

puts 'Finished!'
