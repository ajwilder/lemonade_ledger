console.log('poo');
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
    document.querySelector('#checklist_submit').classList.remove('hidden')
  } else {
    document.querySelector('#checklist_submit').classList.add('hidden')
  }
}
;
