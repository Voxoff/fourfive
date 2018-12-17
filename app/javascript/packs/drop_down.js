// clicking on dropdown box initiates dropdown slide
document.querySelectorAll(".field").forEach((field) => {
  field.addEventListener("click", (event) => {
    const drop = field.nextElementSibling
    $(drop).slideToggle()
  })
})

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

    // select
    // console.log(a.value)
    // document.
  })
})
