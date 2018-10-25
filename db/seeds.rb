puts 'Cleaning database...'
Review.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all
puts 'Creating products...'

p = Product.create!(price: 1, name: 'Lemon', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 3, name: 'Orange', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 2, name: 'Chocolate', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 1, name: 'Pure', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')
Product.create!(price: 3, name: 'Mint', remote_photo_url: 'https://floydsofleadville.com/wp-content/uploads/2018/02/FOL_CBD_Softgels_FullSpectrum_50mg_Front_1200-compressor.jpg')


user = User.create!(email: "admin@admin.com", password: "123123")
puts 'Creating Reviews...'

Review.create!(product_id: p.id, user_id: user.id, rating: 5)
Review.create!(product_id: p.id, user_id: user.id, rating: 4)
Review.create!(product_id: p.id, user_id: user.id, rating: 4)

puts 'Finished!'
