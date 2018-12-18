// clicking on dropdown box initiates dropdown slide
document.querySelectorAll(".field").forEach((field) => {
  field.addEventListener("click", (event) => {
    const drop = field.nextElementSibling
    $(drop).slideToggle()
  })
})
hash = {
  'natural 500mg': 29.99,
  'natural 1000mg': 59.99,
  'natural 2000mg': 114.99,
  'orange 500mg': 34.99,
  'orange 1000mg': 64.99,
  'orange 2000mg': 119.99
}
// clicking on option changes box's value and collapses dropdown
document.querySelectorAll(".drop-down-item").forEach((item) => {
  item.addEventListener("click", (event) => {
    item.parentElement.previousElementSibling.firstElementChild.innerHTML = item.innerHTML
    $(item.parentElement).slideToggle()
    let quantity = document.getElementById('quantity').innerHTML
    let price = document.getElementById('price')
    if (document.getElementById('product-name').innerHTML == "cbd balms"){
      let select = document.querySelector(`[name=${item.id}]`)
      select.value = item.innerHTML
      console.log(select.value)
      if(select.value == "small"){
        price.innerHTML = 29.99 * quantity
      }
      else if(select.value == "large"){
        price.innerHTML = 59.99 * quantity
      }
    }
    if (document.getElementById('product-name').innerHTML == "cbd oils"){
      tincture = document.getElementById('tincture').innerHTML
      strength = document.getElementById('size').innerHTML
      string = tincture + " " + strength
      real_price = hash[string]
      console.log(string)
      console.log(tincture);
      console.log(real_price)
      price.innerHTML = real_price * quantity;
    }
  })
})
