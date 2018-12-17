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
    let select =  document.querySelector(`[name=${item.id}]`)
    select.value = item.innerHTML
    console.log(select.value)
    let price = document.getElementById('price')
    if (document.getElementById('product-name').innerHTML == "cbd balms"){
      if(select.value == "small"){
        price.innerHTML = 29.99
      }
      else if(select.value == "large"){
        price.innerHTML = 59.99
      }
    }
    if (document.getElementById('product-name').innerHTML == "cbd oils"){
      tincture = document.getElementById('tincture')
      strength = document.getElementById('size')
      string = tincture + " " + strength
      value = hash[string]
    }
  })
})
