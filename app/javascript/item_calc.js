function itemCalc (){
  const price = document.getElementById("item-price");
  const fee = document.getElementById("add-tax-price");
  const itemSum = document.getElementById("profit");

  price.addEventListener("input", () => {    
    fee.innerHTML = Math.round(price.value * 0.1);    
    itemSum.innerHTML = Math.round(price.value * 0.9);
 })
};

window.addEventListener('load', itemCalc);