function observeDecisionTreeSearchfield(url) {
  $('#decision_tree_search').each(function() {
    var $this = $(this);
    $this.addClass('autocomplete');
    $this.attr('data-value-was', $this.val());
    var check = function() {
      var val = $this.val();
      if ($this.attr('data-value-was') != val){
        $this.attr('data-value-was', val);
        $.ajax({
          url: url,
          type: 'get',
          data: {q: $this.val()},
          success: function(data){ $('#decision-tree-answers').html(data); },
          beforeSend: function(){ $this.addClass('ajax-loading'); },
          complete: function(){ $this.removeClass('ajax-loading'); }
        });
      }
    };
    var reset = function() {
      if (timer) {
        clearInterval(timer);
        timer = setInterval(check, 300);
      }
    };
    var timer = setInterval(check, 300);
    $this.bind('keyup click mousemove', reset);
  });
}



$(document).on('click', 'button.decision-tree', function(e){
  $.get($(this).data('url'));
  e.preventDefault();
});

function handleClickOnAnswer(elem) {
  var input = $(elem);

  console.log(input.data('progress'));
  console.log(input.data('answer'));

  $('#progress').val(input.data('progress'));
  $('#answer').val(input.data('answer'));
  hideModal(elem);
}
