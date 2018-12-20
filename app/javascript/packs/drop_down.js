// clicking on dropdown box initiates dropdown slide
document.querySelectorAll(".field").forEach((field) => {
  field.addEventListener("click", (event) => {
    const drop = field.nextElementSibling
    $(drop).slideToggle()
  })
})
natural_lower =
  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992689/dmnmdrxjzunmhjrt1xio.jpg";
natural_medium =
  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992753/wmitmcbmups8xcylimlj.jpg";
natural_higher =
  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992764/ykuh6iiuaehxqkqtfiqb.jpg";

orange_lower =
  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992804/mejkv6uikqhnq2eu0l2d.jpg";
orange_medium =
  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992791/qobwn7sblybncdty1eox.jpg";
orange_higher =
  "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992778/ph6rqpze8dv6552itwhf.jpg";
const balmHash = { "Small": 29.99, "Large": 59.99 };
const oilHash = {
  "Natural 500mg": {src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992689/dmnmdrxjzunmhjrt1xio.jpg", price: 29.99 },
  "Natural 1000mg": {src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992753/wmitmcbmups8xcylimlj.jpg", price: 59.99},
  "Natural 2000mg": {src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992764/ykuh6iiuaehxqkqtfiqb.jpg", price: 114.99 },
  "Orange 500mg": {src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992804/mejkv6uikqhnq2eu0l2d.jpg", price: 34.99 },
  "Orange 1000mg": {src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992791/qobwn7sblybncdty1eox.jpg", price: 64.99 },
  "Orange 2000mg": {src: "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1544992778/ph6rqpze8dv6552itwhf.jpg", price: 119.99 }
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
    }
    else if (window.location.pathname.includes("oils")){
      const tincture = document.getElementById('tincture').innerHTML
      const strength = document.getElementById('size').innerHTML
      const key = tincture + " " + strength
      price.innerHTML = oilHash[key]["price"] * quantity;
      document.getElementById('product-photo').src = oilHash[key]["src"]
      document.getElementById('product-name').innerText = key
    }
  })
})
