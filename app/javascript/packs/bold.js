function boldString(str, find){
  var re = new RegExp(find, 'g');
  return str.replace(re, '<b>'+find+'</b>');
}
let strings = document.querySelectorAll(".text")
strings.forEach((i) => {
  res = boldString(i.innerHTML, "fourfive")
  i.innerHTML = res
})
