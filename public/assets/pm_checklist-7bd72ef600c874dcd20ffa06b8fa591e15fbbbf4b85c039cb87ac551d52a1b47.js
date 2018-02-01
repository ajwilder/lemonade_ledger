
var checkboxes = document.querySelectorAll('input[type="checkbox"]')

checkboxes.forEach(function(checkbox){
  checkbox.addEventListener('click', checkChecklist)
})

function checkChecklist() {
  var checked = true
  checkboxes.forEach(function(box) {
    if (box.checked == false) checked = false;
  });
  if (checked){
    document.querySelector('.initials').classList.remove('hidden')
  } else {
    document.querySelector('.initials').classList.add('hidden')
  }
}


document.querySelector('#initials_input').addEventListener('input', function(){
  setTimeout(function() {
    document.querySelector('#checklist_submit').classList.remove('hidden')
  }, 1000)
} )
;
