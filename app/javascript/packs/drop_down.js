// clicking on dropdown box initiates dropdown slide
document.querySelectorAll(".field").forEach((field) => {
  field.addEventListener("click", (event) => {
    const drop = field.nextElementSibling
    $(drop).slideToggle()
  })
})

const balmHash = { "small": 29.99, "large": 59.99 };
const oilHash = {
  "natural 500mg": 29.99,
  "natural 1000mg": 59.99,
  "natural 2000mg": 114.99,
  "orange 500mg": 34.99,
  "orange 1000mg": 64.99,
  "orange 2000mg": 119.99
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
      price.innerHTML = balmHash[key] * quantity
    }
    else if (window.location.pathname.includes("oils")){
      const tincture = document.getElementById('tincture').innerHTML
      const strength = document.getElementById('size').innerHTML
      price.innerHTML = oilHash[tincture + " " + strength] * quantity;
    }
  })
})
