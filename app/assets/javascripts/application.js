// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .

window.addEventListener("load", function() {
  var toggleButton = document.getElementById("toggle-comments")
  if (toggleButton != null) {
    toggleButton.addEventListener("click", function(e) {
      e.preventDefault();
      var comments = document.getElementById("comments");
      if(comments.style.display == "none") {
        comments.style.display = "block";
        this.innerHTML = 'Hide comments';
      } else {
        comments.style.display = "none";
        this.innerHTML = 'Show comments';
      }
    });
  }

  var summaryElements = document.querySelectorAll('.summary');
  for (var i = 0; i < summaryElements.length - 1; i++){
    summaryElements[i].addEventListener('click', function(e){
      e.preventDefault();
        var request = new XMLHttpRequest();
        request.open("GET", this.href);
        request.responseType = 'json';
        request.addEventListener("load", function () {
          var summary = document.getElementById('summary-' + this.response.id)
            summary.innerText = 'Comments: ' + this.response.comments + '. Likes: ' + this.response.likes
          });
        request.send();
    });
  }
});
