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
    // console.log(item.id)
    // console.log(item.innerHTML)
//
    let select =  document.querySelector(`[name=${item.id}]`)
    select.value = item.innerHTML
    // select
    // console.log(a.value)
    // document.
  })
})
