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
const balmHash = { "Small": { src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992617/ccsl3c44jbf7rxfjirhr.jpg", price: 29.99 }, "Large": { src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992640/khtunfbpau6bjjzwxgf6.jpg", price: 59.99} };
const oilHash = {
  "Natural 500mg": {src: natural_lower, price: 29.99 },
  "Natural 1000mg": {src: natural_medium, price: 59.99},
  "Natural 2000mg": {src: natural_higher, price: 114.99 },
  "Orange 500mg": {src: orange_lower, price: 34.99 },
  "Orange 1000mg": {src: orange_medium, price: 64.99 },
  "Orange 2000mg": {src: orange_higher, price: 119.99 }
};


// clicking on option changes box's value and collapses dropdown
document.querySelectorAll(".drop-down-item").forEach((item) => {
  item.addEventListener("click", (event) => {
    item.parentElement.previousElementSibling.firstElementChild.innerHTML = item.innerHTML
    $(item.parentElement).slideToggle()
    const quantity = document.getElementById('quantity').innerHTML
    const price = document.getElementById('price')
    if (window.location.pathname.includes("balms")){
      let key = document.getElementById("size").innerHTML;
      key = item.innerHTML
      price.innerHTML = balmHash[key]["price"] * quantity
      document.getElementById('product-photo').src = balmHash[key]["src"]
    }
    else if (window.location.pathname.includes("oils")){
      const tincture = document.getElementById('tincture').innerHTML
      const strength = document.getElementById('size').innerHTML
      const key = tincture + " " + strength
      price.innerHTML = oilHash[key]["price"] * quantity;
      document.getElementById('product-photo').classList.add('transparent')
      document.getElementById('product-photo').src = oilHash[key]["src"]
      document.getElementById('product-name').innerText = key
    }
  })
})
