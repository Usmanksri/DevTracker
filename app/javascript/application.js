// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"



//console.log("javascript tested");
$(document).ready(function() {
  // Test code here
  //console.log("jQuery is working!");

  $('input[type="radio"][name^="status_"]').change(function() {
    var taskID = $(this).data('taskId'); // Updated to use 'taskId'
    var status = $(this).val();
    var taskURL = '/tasks/' + taskID; // Replace with the actual URL or path to the task

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
        // Handle error response here if needed
      }
    });
  });

    // Pagination with scrolling
    //debugger
    $(window).on('scroll', function() {
      var url = $('.pagination .next_page a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text('Loading more projects...');
        $.getScript(url);
      }
    });


  // // Show the flash notice container with a fade-in effect
  // $('.flash-notice-container, .flash-alert-container').fadeIn('slow');
  
  // // Hide the flash notice containers after a certain time (e.g., 5 seconds)
  // setTimeout(function() {
  //   $('.flash-notice-container, .flash-alert-container').fadeOut('slow');
  // }, 5000);
});

