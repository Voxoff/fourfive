// clicking on dropdown box initiates dropdown slide
document.querySelectorAll(".field").forEach((field) => {
  field.addEventListener("click", (event) => {
    const drop = field.nextElementSibling
    $(drop).slideToggle()
  })
})
// Setting up data
const natural_lower = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310487/fca5phhhi05oy3rbilqe.jpg"
const natural_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310517/ykz2clyc02odmzfazffc.jpg"
const natural_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310539/s4o3j4g8u38yw5ydp9dl.jpg"

const orange_lower = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310603/wsz1iktl65jfnzf0usno.jpg"
const orange_medium = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310585/unumz5jvzglclwxw2rik.jpg"
const orange_higher = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545310560/ynbhmsk6vqsnefuagu1u.jpg"

const small_balm = "https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545330419/zdilgiei86tpd8u0wkbc.jpg";
const large_balm ="https://res.cloudinary.com/dq2kcu9ey/image/upload/v1545330449/go6ereapuoyjqepenvk6.jpg";

const balmHash = {
  "Small balm": { src: small_balm, price: 29.99 },
  "Large balm": { src: large_balm, price: 59.99 }
};

const oilHash = {
  'Natural Lower (500mg)': { src: natural_lower, price: 29.99 },
  'Natural Medium (1000mg)': { src: natural_medium, price: 59.99},
  'Natural Higher (2000mg)': { src: natural_higher, price: 114.99 },
  'Orange Lower (500mg)': { src: orange_lower, price: 34.99 },
  'Orange Medium (1000mg)': { src: orange_medium, price: 64.99 },
  'Orange Higher (2000mg)': { src: orange_higher, price: 119.99 }
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
      if (key == "Small balm"){
        size = " (30ml / 300mg)"
      } else {
        size = " (100ml / 800mg)"
      }
      document.getElementById('product-name').innerText = key + size
      document.getElementById('product-photo').src = balmHash[key]["src"]
      document.querySelector("[name=size]").value = key.split(" ")[0]

    }
    else if (window.location.pathname.includes("oils")){
      const tincture = document.getElementById('tincture').innerText.trim()
      const strength = document.getElementById('size').innerText.trim()
      const key = tincture + " " + strength
      price.innerHTML = oilHash[key]["price"] * quantity;
      document.getElementById('product-photo').classList.add('transparent')
      document.getElementById('product-photo').src = oilHash[key]["src"]
      document.getElementById('product-name').innerText = key
      let size = strength.split(" ")[0];
      hash = {"Lower": "500mg", "Medium": "1000mg", "Higher": "2000mg"}
      document.querySelector("[name=size]").value = hash[size]
      // debugger
      document.querySelector("[name=tincture]").value = tincture

    }
  })
})

// a script to update quantity bought.
const lessButton = document.querySelector('#less')
const moreButton = document.querySelector("#more");
const buttons = [lessButton, moreButton];

const inputs = document
  .querySelector(".button_to")
  .getElementsByTagName("input");

const quantityParam = [...inputs].filter(i => i.name == "quantity")[0];

buttons.forEach((button) => {
  button.addEventListener("click", (e) => {
    // different product ranges and number of dropdowns
    let realPrice
    if (window.location.pathname.includes("balms")) {
      let select = document.getElementById("size").innerText.trim();
      realPrice = balmHash[select]["price"];
    } else if (window.location.pathname.includes("oils")) {
      let tincture = document.getElementById("tincture").innerText.trim();
      let strength = document.getElementById("size").innerText.trim();
      realPrice = oilHash[tincture + " " + strength]["price"];
    } else if (window.location.pathname.includes("capsules")) {
      realPrice = 39.99
    }
    let number = Number.parseInt(document.getElementById('quantity').innerText)
    if (number > 1 && button.id == "less") {
      quantity.innerHTML = number - 1;
      quantityParam.value = number - 1;
    }
    else if (button.id == "more") {
      quantity.innerHTML = number + 1;
      quantityParam.value = number + 1;
    }
    let roundPrice = realPrice * quantity.innerHTML;
    document.querySelector("#price").innerHTML = Math.round(100 * roundPrice) / 100;
  })
})
