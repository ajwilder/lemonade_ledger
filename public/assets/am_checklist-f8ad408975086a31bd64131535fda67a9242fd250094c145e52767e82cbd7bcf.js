




farmers_checklist = document.querySelector('#farmers_checklist')
city_checklist = document.querySelector('#city_checklist')
var farmers = false;
var city = false;

var location_field = document.querySelector('#location')

location_field.addEventListener('change', changeLocation)


function changeLocation() {
  if (this.value == "Market Street") {
    city = true
    city_checklist.classList.remove('hidden')
    if (farmers == true) {
      farmers = false;
      farmers_checklist.classList.add('hidden')
    }
  } else {
    farmers = true;
    farmers_checklist.classList.remove('hidden')
    if (city == true) {
      city = false;
      city_checklist.classList.add('hidden')
    }
  }
}



var checkboxes = document.querySelectorAll('input[type="checkbox"]')

checkboxes.forEach(function(checkbox){
  checkbox.addEventListener('click', checkChecklist)
})

function checkChecklist() {
  if (farmers){
    var boxes = document.querySelectorAll('.farmers_checkbox')
  } else {
    var boxes = document.querySelectorAll('.city_checkbox')
  }
  var checked = true
  boxes.forEach(function(box) {
    if (box.checked == false) checked = false;
  });
  if (checked){
    document.querySelector('#checklist_submit').classList.remove('hidden')
  } else {
    document.querySelector('#checklist_submit').classList.add('hidden')
  }
}
;
