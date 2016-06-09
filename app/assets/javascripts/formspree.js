var FormSpree = FormSpree || {};

+function($, ga) {
  FormSpree.submit = function(form) {
    document.getElementById('applyButton').disabled = 'disabled';

    $.ajax({
      url: form.action, 
      method: 'POST',
      data: {
        name: form.name.value,
        _replyto: form._replyto.value
      },
      dataType: 'json'
    }).done(function() {
      $('#applyButton').hide();
      ga('send', 'event', 'application', 'submit');
      $('#applyThanks').show();
    }).fail(function() {
      alert('Oops, that didn\'t work. Double-check your info and try again.');
      document.getElementById('applyButton').disabled = '';
    });
    
    return false;
  };
}(jQuery, ga);
