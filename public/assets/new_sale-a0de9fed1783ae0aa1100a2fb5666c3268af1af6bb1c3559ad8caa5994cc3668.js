document.addEventListener("DOMContentLoaded", clearStorage)

//Local variable to change price for vendors
var vendor = false;
var freebie = false;

// Add EventListeners for item buttons
var buttons = document.querySelectorAll('.item_button')
var table = document.querySelector('.sale_items')
var priceDisplay = document.querySelector('#price_sum')
buttons.forEach(function(button) {
  button.addEventListener('click', handleItemClick)
})

// stores any new items in localstorage.  Iterates over local storage to display items on screen and store them in the hidden form fields
function handleItemClick() {
  var itemName = this.dataset.name
  var itemPrice
  if (vendor == false && freebie == false){
    itemPrice = this.dataset.price;
  } else if (vendor == true) {
    itemPrice = this.dataset.vendor_price;
    itemName += '(v)'
  } else {
    itemPrice = 0;
    itemName += '(f)'
  }
  if(this.dataset.action == "remove") {
    if (localStorage[itemName]) {
      var o = localStorage.getItem(itemName)
      o = JSON.parse(o)
      o.count--;
      if (o.count == 0) {
        localStorage.removeItem(itemName)
      } else {
          localStorage[itemName] = JSON.stringify(o)
      }
    }
  }
  if (this.dataset.action == "add") {
    if (localStorage[itemName]) {
      var o = localStorage.getItem(itemName)
      o = JSON.parse(o)
      o.count++;
      localStorage[itemName] = JSON.stringify(o)
    } else {
      localStorage.setItem(itemName, JSON.stringify({'count': 1, 'price': itemPrice, 'cup_type': this.dataset.cup, 'name': itemName}));
    }
  }
  updatePage()
}

// Updates page with all data form localStorage
function updatePage() {
  table.innerHTML = '';
  var totalPrice = 0.0;
  cup_fields = document.querySelectorAll('.sale_cups');
  cup_fields.forEach(function(field) {
    field.value = 0;
  });
  var itemNames = ''
  for (var i = 0; i < localStorage.length; i++){
    var item = JSON.parse(localStorage.getItem(localStorage.key(i)));
    cup_type = item.cup_type;
    if (cup_type) {
      cup_field = document.querySelector(`#sale_${cup_type}`);
      current_cups = cup_field.value;
    }
    for (var j = 0; j < item.count; j++){
      itemNames += item.name + ','
      if (cup_type) current_cups++;
      var row = document.createElement('tr');
      var itemName = document.createElement('td');
      var price = document.createElement('td');
      itemName.appendChild(document.createTextNode(item.name));
      price.appendChild(document.createTextNode(parseFloat(item.price).toFixed(2)));
      row.appendChild(itemName);
      row.appendChild(price);
      table.appendChild(row);
      totalPrice += parseFloat(item.price);
    }
    if (cup_type) cup_field.value = current_cups;
  }
  priceDisplay.textContent = totalPrice.toFixed(2);
  document.querySelector('#sale_price').value = totalPrice;
  document.querySelector('#items').value = itemNames;
}

// Calculates change
var cash_tendered = document.querySelector('#cash_tendered');
cash_tendered.addEventListener('keyup', calculateChange)

function calculateChange() {
  var change = this.value - parseFloat(priceDisplay.textContent);
  if (change > 0) {
    document.querySelector('#sale_change').innerHTML = '$' + change.toFixed(2)
  } else {
    document.querySelector('#sale_change').innerHTML = 0
  }
}

// Align permanent buttons to top of table
var perm_buttons_divs = document.querySelectorAll('.permanent_items');
var table = document.querySelector('.sale_items')
var freebie_div = document.querySelector('.freebie_div')
var multi_div = document.querySelector('.item_div__multi')

perm_buttons_divs.forEach(function(div){
  div.style.top = table.offsetTop + 'px'
})
freebie_div.style.top = table.offsetTop + 170 + 'px'
multi_div.style.top = table.offsetTop + 340 + 'px'

var misc_div = document.querySelector('.item_div__misc');
var clear_div = document.querySelector('.clear_all_div');
var vendor_div = document.querySelector('.vendor_div');
var item_divs = document.querySelectorAll('.item_div')

clear_div.style.right = (window.innerWidth - (parseInt(item_divs[0].offsetLeft) + 160)) +  'px'
freebie_div.style.right = (window.innerWidth - (parseInt(item_divs[0].offsetLeft) + 160)) +  'px'
vendor_div.style.right = (window.innerWidth - (parseInt(item_divs[1].offsetLeft) + 160)) +  'px'
misc_div.style.right = (window.innerWidth - (parseInt(item_divs[2].offsetLeft) + 160)) +  'px'
multi_div.style.right = (window.innerWidth - (parseInt(item_divs[0].offsetLeft) + 160)) +  'px'

// Add misc_item to sale
var misc_item_buttons = document.querySelectorAll('.misc_item_button');
var misc_item_price = document.querySelector('#misc_item_price');
var misc_item_cup_type = document.querySelector('#misc_item_cup_type')
var misc_item_name = document.querySelector('#misc_item_name')
misc_item_buttons.forEach(function(button) {
  button.addEventListener('click', handleMiscItemClick)
})

function handleMiscItemClick() {
  var itemName
  var itemPrice = parseFloat(misc_item_price.value)
  if (isNaN(itemPrice)) {
    return;
  }
  var cup_type = misc_item_cup_type.value
  var inputted_name = misc_item_name.value
  if (!inputted_name) inputted_name = '?';
  if (cup_type){
    itemName = `Misc. $${itemPrice.toFixed(2)} Item (${inputted_name}) w/${cup_type}  ${ cup_type == 'Bottle' ? '' : 'cup'}`;
  } else {
    itemName = `Misc. $${itemPrice.toFixed(2)} Item (${inputted_name})`
  }
  if(this.dataset.action == "remove") {
    if (localStorage[itemName]) {
      var o = localStorage.getItem(itemName)
      o = JSON.parse(o)
      o.count--;
      if (o.count == 0) {
        localStorage.removeItem(itemName)
      } else {
          localStorage[itemName] = JSON.stringify(o)
      }
    }
  }
  if (this.dataset.action == "add") {
    if (localStorage[itemName]) {
      var o = localStorage.getItem(itemName)
      o = JSON.parse(o)
      o.count++;
      localStorage[itemName] = JSON.stringify(o)
    } else {
      localStorage.setItem(itemName, JSON.stringify({'count': 1, 'price': itemPrice, 'cup_type': cup_type.replace(' ','_').toLowerCase(), 'name': itemName}));
    }
  }
  updatePage()
}

// toggle the freebie and vender prices
vendor_div.addEventListener('click', toggleVendor)
function toggleVendor() {
  if (vendor == false) {
    vendor = true;
    vendor_div.style.background = 'green';
    if (freebie == true) {
      toggleFreebie()
    }
  } else {
    vendor = false;
    vendor_div.style.background = '#ffd891';
  }
}

freebie_div.addEventListener('click', toggleFreebie)
function toggleFreebie() {
  if (freebie == false) {
    freebie = true;
    freebie_div.style.background = 'green'
    if (vendor = true) {
      toggleVendor()
    }
  } else {
    freebie = false;
    freebie_div.style.background = '#ffd891';
  }

}

// Add multi_item to sale
var multi_item_buttons = document.querySelectorAll('.multi_item_button');
var multi_item_name = document.querySelector('#multi_item_name')
var multi_item_number = document.querySelector('#multi_item_number')
multi_item_buttons.forEach(function(button) {
  button.addEventListener('click', handleMultiItemClick)
})


function handleMultiItemClick() {
  var itemName = multi_item_name.value
  var dataDiv = document.querySelector(`[data-name="${itemName}"]`)
  var quantity = parseInt(multi_item_number.value)
  var itemPrice = dataDiv.dataset.price
  var cupType = dataDiv.dataset.cup
  if(this.dataset.action == "remove") {
    if (localStorage[itemName]) {
      var o = localStorage.getItem(itemName)
      o = JSON.parse(o)
      if ((o.count - quantity) >= 0) {
        o.count -= quantity;
      } else {
        o.count = 0;
      };
      if (o.count == 0) {
        localStorage.removeItem(itemName)
      } else {
          localStorage[itemName] = JSON.stringify(o)
      }
    }
  }
  if (this.dataset.action == "add") {
    if (localStorage[itemName]) {
      var o = localStorage.getItem(itemName)
      o = JSON.parse(o)
      o.count += quantity;
      localStorage[itemName] = JSON.stringify(o)
    } else {
      localStorage.setItem(itemName, JSON.stringify({'count': quantity, 'price': itemPrice, 'cup_type': cupType.replace(' ','_').toLowerCase(), 'name': itemName}));
    }
  }
  updatePage()
}

// clear local storage when clear all button clicked

clear_div.addEventListener('click', clearStorage)



// Clears localStorage when you leave the page or enter the page
var submit = document.querySelector('#sale_submit');
var back_button = document.querySelector('#back_ledger');
var home = document.querySelector('#header_button');
submit.addEventListener('click', clearStorage);
back_button.addEventListener('click', clearStorage);
home.addEventListener('click', clearStorage);

function clearStorage() {
  priceDisplay.textContent = ''
  table.innerHTML = '';
  localStorage.clear()
}
;
