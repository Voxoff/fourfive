// a script to update quantity bought.
const lessButton = document.querySelector('#less')
const moreButton = document.querySelector("#more");
const buttons = [lessButton, moreButton];

const quantityParam = document
  .querySelector(".button_to")
  .getElementsByTagName("input")[3];

let balmHash = { "Small": 29.99, "Large": 59.99 };
let oilHash = {
  'Natural Lower (500mg)': 29.99,
  'Natural Medium (1000mg)': 59.99,
  'Natural Higher (2000mg)': 114.99,
  'Orange Lower (500mg)': 34.99,
  'Orange Medium (1000mg)': 64.99,
  'Orange Higher (2000mg)': 119.99
}

buttons.forEach((button) => {
  button.addEventListener("click", (e) => {
    // different product ranges and number of dropdowns
    let realPrice
    if (window.location.pathname.includes("balms")) {
      let select = document.getElementById("size").innerHTML;
      realPrice = balmHash[select];
    } else if (window.location.pathname.includes("oils")) {
      hash = oilHash;
      let tincture = document.getElementById("tincture").innerHTML;
      let strength = document.getElementById("size").innerHTML;
      realPrice = hash[tincture + " " + strength];
    }

    let number = Number.parseInt(document.getElementById('quantity').innerText)
    if (number >= 1 && button.id == "less") {
      quantity.innerHTML = number - 1
      quantityParam.value = number - 1
    }
    else if (button.id == "more"){
      quantity.innerHTML = number + 1
      quantityParam.value = number + 1
    }
    let roundPrice = realPrice * quantity.innerHTML;
    document.querySelector("#price").innerHTML = Math.round(100 * roundPrice) / 100;
  })
})
