puts 'Cleaning database...'
Review.destroy_all
Strength.destroy_all
Product.destroy_all
User.destroy_all
puts 'Creating products...'




balm_help = ["Aches", "Sprains", "Tendon inflammation", "Muscle inflammation", "Localised pain (including knees, hands, shoulders & elbows)", "Psoriasis ", "Acne", "Eczema", "Grazes", "Minor burns"]
balm_how_to = "Swallow with food. We recommend starting by taking one capsule once or twice a day. you can then increase your dose over time. Generally, we have seen customers take an average of two to four capsules of cbd per day. Please do not go over the 200mg food supplement daily limit (forty capsules)"
balm_ingr = ["Vegetable capsule", "Hemp extract", "Coconut oil", "May contain traces of nuts"]
balm_desc = "Because your skin it the largest working organ, we’ve created a soothing, safe and protective application for it. Made with organic ingredients, our hand-blended and hard-working balm is kind to all skin types."


oil_help = ["Stress relief", "Anti-inflammatory", "Sleep patterns", "Relieving of anxiety", "Easing mild depression", "Calming nerves"]
oil_how_to = "Apply on to the targeted area of your skin and rub until fully absorbed. For external use only."
oil_ingr = ["Hemp extract", "Coconut oil", "May contain traces of nuts"]
oil_desc = "Quick-absorbing and easy-to-use cbd oils. Made with 100% natural and organic ingredients. Our process of CO2 extraction means the highest available nutritional value is packed in to every drop of fourfive cbd oil. Each of our bottles contain roughly 120 drops."

capsule_help = ["Arthritis", "Muscle stiffness", "Management of Fibromyalgia", "Inflammatory disorders"]
capsule_how_to = "We recommend starting with 3 drops of the lower strength oil twice a day. To take simply drop the cdb oil under your tongue using the pipette or the spray. This achieves the best possible absorption rates and bioavailability. \n You can then increase the dosage as required on a weekly basis, to a maximum of 6 drops twice a day, until the desired results are achieved. \n If you find that you’re nearing the end of the bottle and you’re already taking 6 drops twice a day but it isn’t hitting the spot, we would recommend upgrading to our regular or higher strength cbd oil."
capsule_ingr = ["Coconut oil", "Hemp extract", "Vegetable capsule"]
capsule_desc = "Our cbd capsules contain full-spectrum, co2 extracted hemp infused in coconut oil and capped in vegan capsules. They are easy-to-use and slow-to-release, great for when you only need a small amount of cbd product over a longer period of time."

#Photos cloudinary

balm_300 = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992617/ccsl3c44jbf7rxfjirhr.jpg"
balm_800 = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992640/khtunfbpau6bjjzwxgf6.jpg"
capsule = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992665/dec1hxtk9pxpj9tpjm7i.jpg"
natural_lower = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992689/dmnmdrxjzunmhjrt1xio.jpg"
natural_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992753/wmitmcbmups8xcylimlj.jpg"
natural_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992764/ykuh6iiuaehxqkqtfiqb.jpg"

orange_lower = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992804/mejkv6uikqhnq2eu0l2d.jpg"
orange_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992791/qobwn7sblybncdty1eox.jpg"
orange_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992778/ph6rqpze8dv6552itwhf.jpg"



Product.create!(name: 'cbd capsules',
               price: 3,
               help: balm_help,
               how_to_use: capsule_how_to,
               ingredients: capsule_ingr,
               subtitle: "Easy-to-take capsules for slower release",
               description: capsule_desc,
               photo: open(capsule))

Product.create!(name: 'cbd balms',
                size: "small",
               price: 29.99,
               help: capsule_help,
               how_to_use: balm_how_to,
               ingredients: balm_ingr,
               subtitle: "Organic balms for damaged skin",
               description: balm_desc,
               photo: open(balm_300))

Product.create!(name: 'cbd balms',
               size: "large",
               price: 59.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: balm_desc,
               photo: open(balm_800))

p = Product.create!(name: 'cbd oils',
               size: "500mg",
               tincture: "natural",
               price: 29.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(natural_lower),
               dosage: "spray")


Product.create!(name: 'cbd oils',
               size: "1000mg",
               tincture: "natural",
               price: 59.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(natural_medium),
               dosage: "spray")

Product.create!(name: 'cbd oils',
               size: "2000mg",
               tincture: "natural",
               price: 29.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(natural_higher),
               dosage: "spray")

Product.create!(name: 'cbd oils',
               size: "500mg",
               tincture: "orange",
               price: 114.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(orange_lower),
               dosage: "spray")

Product.create!(name: 'cbd oils',
               size: "1000mg",
               tincture: "orange",
               price: 64.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(orange_medium),
               dosage: "spray")

Product.create!(name: 'cbd oils',
               size: "2000mg",
               tincture: "orange",
               price: 119.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(orange_higher),
               dosage: "spray")

Product.create!(name: 'cbd oils',
               size: "500mg",
               tincture: "natural",
               price: 29.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(natural_lower),
               dosage: "pipette")


Product.create!(name: 'cbd oils',
               size: "1000mg",
               tincture: "natural",
               price: 59.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(natural_medium),
               dosage: "pipette")

Product.create!(name: 'cbd oils',
               size: "2000mg",
               tincture: "natural",
               price: 29.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(natural_higher),
               dosage: "pipette")

Product.create!(name: 'cbd oils',
               size: "500mg",
               tincture: "orange",
               price: 114.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(orange_lower),
               dosage: "pipette")

Product.create!(name: 'cbd oils',
               size: "1000mg",
               tincture: "orange",
               price: 64.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(orange_medium),
               dosage: "pipette")

Product.create!(name: 'cbd oils',
               size: "2000mg",
               tincture: "orange",
               price: 119.99,
               help: oil_help,
               how_to_use: oil_how_to,
               ingredients: oil_ingr,
               subtitle: "Flavored oils for quick absorption",
               description: oil_desc,
               photo: open(orange_higher),
               dosage: "pipette")







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


puts 'Finished!'
