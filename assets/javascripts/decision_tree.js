$(document).on('click', 'button.decision-tree', function(e){
  $.get($(this).data('url'));
  $(document).ajaxComplete(function(){
    $('div.ui-dialog')[0].scrollIntoView()
  })
  e.preventDefault();
});
