import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
// update the status of tasks
$(document).ready(function() {
  $('input[type="radio"][name^="status_"]').change(function() {
    var taskID = $(this).data('taskId');
    var status = $(this).val();
    var taskURL = '/tasks/' + taskID; 
    console.log("task url is: ", taskURL);

    $.ajax({
      url: taskURL,
      type: 'PATCH',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      data: { task: { status: status } },
      dataType: 'json',
      success: function(response) {
        console.log(response);
      },
      error: function(xhr, status, error) {
        console.log("exception occurred ", error);
      }
    });
  });
  // appends the tasks and projects on scroll
    var next_page = $('#next_data').data('next-page');
    if (next_page) {
      var visitedUrl = undefined;
      $(window).on('scroll', function() {
        var url = $('.pagination a.next_page').attr('href');
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 20) {
          if (visitedUrl !== url) {
            $.getScript(url);
            visitedUrl = url;
          }
        }
      });
    }

    // hide the flash and notice messages 
      $('.flash-notice-container, .flash-alert-container').fadeIn('slow');
      setTimeout(function() {
        $('.flash-notice-container, .flash-alert-container').fadeOut('slow');
      }, 5000);
});






