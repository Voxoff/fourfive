// clicking on dropdown box initiates dropdown slide
document.querySelectorAll(".field").forEach((field) => {
  field.addEventListener("click", (event) => {
    const drop = field.nextElementSibling
    $(drop).slideToggle()
  })
})
natural_lower = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310487/fca5phhhi05oy3rbilqe.jpg"
natural_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310517/ykz2clyc02odmzfazffc.jpg"
natural_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310539/s4o3j4g8u38yw5ydp9dl.jpg"

orange_lower = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310603/wsz1iktl65jfnzf0usno.jpg"
orange_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310585/unumz5jvzglclwxw2rik.jpg"
orange_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310560/ynbhmsk6vqsnefuagu1u.jpg"
const balmHash = {
  "Small balm": {
    src:
      "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545330419/zdilgiei86tpd8u0wkbc.jpg",
    price: 29.99
  },
  "Large balm": {
    src:
      "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545330449/go6ereapuoyjqepenvk6.jpg",
    price: 59.99
  }
};
const oilHash = {
 'Natural Lower (500mg)': {src: natural_lower, price: 29.99 },
  'Natural Medium (1000mg)': {src: natural_medium, price: 59.99},
  'Natural Higher (2000mg)': {src: natural_higher, price: 114.99 },
  'Orange Lower (500mg)': {src: orange_lower, price: 34.99 },
 'Orange Medium (1000mg)': {src: orange_medium, price: 64.99 },
 'Orange Higher (2000mg)': {src: orange_higher, price: 119.99 }
};


// clicking on option changes box's value and collapses dropdown
document.querySelectorAll(".drop-down-item").forEach((item) => {
  item.addEventListener("click", (event) => {
    item.parentElement.previousElementSibling.firstElementChild.innerHTML = item.innerHTML
    $(item.parentElement).slideToggle()
    const quantity = document.getElementById('quantity').innerHTML
    const price = document.getElementById('price')
    if (window.location.pathname.includes("balms")){
      let key = document.getElementById("size").innerText.trim()
      key = item.innerText.trim()
      price.innerHTML = balmHash[key]["price"] * quantity
      if (key == "small"){
        size = " (30ml / 300mg)"
      } else {
        size = " (100ml / 800mg)"
      }
      document.getElementById('product-name').innerText = key + size
      document.getElementById('product-photo').src = balmHash[key]["src"]
    }
    else if (window.location.pathname.includes("oils")){
      const tincture = document.getElementById('tincture').innerText.trim()
      const strength = document.getElementById('size').innerText.trim()
      const key = tincture + " " + strength
      price.innerHTML = oilHash[key]["price"] * quantity;
      document.getElementById('product-photo').classList.add('transparent')
      document.getElementById('product-photo').src = oilHash[key]["src"]
      document.getElementById('product-name').innerText = key+ " (30ml)"
    }
  })
})
