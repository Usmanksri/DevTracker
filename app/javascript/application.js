import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";

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

});



// will be used later for showin and hiding of flash messages
  // // Show the flash notice container with a fade-in effect
  // $('.flash-notice-container, .flash-alert-container').fadeIn('slow');
  // // Hide the flash notice containers after a certain time (e.g., 5 seconds)
  // setTimeout(function() {
  //   $('.flash-notice-container, .flash-alert-container').fadeOut('slow');
  // }, 5000);

