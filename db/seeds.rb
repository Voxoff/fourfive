puts 'Cleaning database...'
Review.destroy_all
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

cartoon_photo = "http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543757174/eb8bk1ntavsaotcdmui0.png"

balm_group_photo = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545222897/syednxs9q1f1xdv8lfqn.jpg"
oil_group_photo = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545222966/th9jem5lvuuhxjgsfwya.jpg"
capsules_photo = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310996/g9l7hk0dbiii7fkjcq9r.jpg"
natural_lower =  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310487/fca5phhhi05oy3rbilqe.jpg"
natural_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310517/ykz2clyc02odmzfazffc.jpg"
natural_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310539/s4o3j4g8u38yw5ydp9dl.jpg"

orange_lower =  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310603/wsz1iktl65jfnzf0usno.jpg"
orange_medium =  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310585/unumz5jvzglclwxw2rik.jpg"
orange_higher =  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310560/ynbhmsk6vqsnefuagu1u.jpg"

oil_inter = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310755/ny59enepz05qvp94tt9f.jpg"
balm_inter = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310778/sl30jmqwyb9mij3bcbcd.jpg"
capsules_inter = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310803/veuj8rtogmvgswpoadxu.jpg"

capsules = ProductGroup.create(name: 'cbd_capsules', help: capsule_help,
how_to_use: capsule_how_to,
ingredients: capsule_ingr,
subtitle: "Easy-to-take capsules for slower release",
description: capsule_desc,
photo: open(capsules_photo))

balms = ProductGroup.create(name: 'cbd_balms', help: balm_help,
how_to_use: balm_how_to,
ingredients: balm_ingr,
subtitle: "Organic balms for damaged skin",
description: balm_desc,
photo: open(balm_group_photo))

oils = ProductGroup.create(name: 'cbd_oils', help: oil_help,
how_to_use: oil_how_to,
ingredients: oil_ingr,
subtitle: "Flavored oils for quick absorption",
description: oil_desc,
photo: open(oil_group_photo))


Product.create!(product_group: capsules, name: 'cbd_capsules', price: 39.99, photo: open(capsule))
Product.create!(product_group: balms, name: 'cbd_balms', size: "Small", price: 29.99, photo: open(balm_300))
Product.create!(product_group: balms, name: 'cbd_balms', size: "Large", price: 59.99, photo: open(balm_800))
p = Product.create!(product_group: oils, name: 'cbd_oils', size: "500mg", tincture: "Natural", price: 29.99, photo: open(natural_lower))

Product.create!(product_group: oils, name: 'cbd_oils', size: "1000mg", tincture: "Natural", price: 59.99, photo: open(natural_medium))
Product.create!(product_group: oils, name: 'cbd_oils', size: "2000mg", tincture: "Natural", price: 29.99, photo: open(natural_higher))
Product.create!(product_group: oils, name: 'cbd_oils', size: "500mg", tincture: "Orange", price: 114.99, photo: open(orange_lower))
Product.create!(product_group: oils, name: 'cbd_oils', size: "1000mg", tincture: "Orange", price: 64.99, photo: open(orange_medium))
Product.create!(product_group: oils, name: 'cbd_oils', size: "2000mg", tincture: "Orange", price: 119.99, photo: open(orange_higher))

puts "Creating user"
user = User.create!(email: "admin@admin.com", admin: true, password: "123123", first_name: "Dominic", last_name: "Day", photo: open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1541431269/lsseq4xw3walhbzdovf3.jpg"))
puts 'Creating Reviews...'


Review.create!(photo: open("https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545169336/vto4twgf2cmc9dpizgfh.jpg"), product_id: p.id, user_id: user.id, name: "Nadia Forde", position: "Model & Actress", content: "My workout routine", desc: "Staying fit and healthy is a key part of my job. With limited time now I'm a mother, I use fourfive cbd to recover quicker after workouts and help me get all-important rest when I need it. Also, a beauty hack for the all-natural balm; I mix  it with my daily moisturiser and its saving my tired skin, reducing puffiness and inflammation.")
Review.create!(photo: open("https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545169312/odv3lpansifs7zkyr7ht.jpg"), product_id: p.id, user_id: user.id, name: "Nathan Trowbridge", position: "Semi Pro rugby player", content: "My recovery from concussion", desc: "After suffering a pretty severe concussion I found it hard to relax and help my brain recover. I used fourfive cbd and it helped me to really feel at ease and rest my anxiety.")
Review.create!(photo: open("https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545169241/iziklekkwsjt92xs5kax.jpg"), product_id: p.id, user_id: user.id, name: "Chris Dicomidis", position: "International rugby player", content: "My recovery from knee ligament injury", desc: "fourfive cbd really helped me recover and manage pain from my recent knee ligament injury. I especially noticed the great sleep I was getting whilst taking it.")



puts 'Finished!'
