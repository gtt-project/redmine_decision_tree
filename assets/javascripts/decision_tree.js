$(document).on('click', 'button.decision-tree', function(e){
  $.get($(this).data('url'));
  e.preventDefault();
});
