//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require_tree .

$( document ).ready(function () {
  $(".loader").hide()

  $(document).ajaxStart(function (){
    $(".loader").show()
  })

  $(document).ajaxStop(function (){
    $(".loader").hide(slow)
    alert('here')
    location.reload()
  })

  $('[data-js-spinner]').click(function (event) {
    $('.loader').show()
  })
})
