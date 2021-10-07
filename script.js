// Author: Shubham Kumar

// initializing tooltips
$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});


// index.html
function proceed() {

    // hide the name_section and greet user
    $('#name_section').addClass('d-none');
    var name = $('#name').val();

    // few links to be appended into the html
    var bootstrap = '<a href=\'https://getbootstrap.com/\'>Bootstrap 4</a>';
    var jquery = '<a href=\'https://jquery.com/\'>jQuery</a>';
    var me = '<a href=\'about.html\'>ME</a>';

    // html
    var html = '<h4 class=\'display-4\' style=\'font-size:36px;\'>Hello, ' + name + '!</h4>';
    html += '<p class=\'lead\'>This is a simple website, created using ';
    html +=  bootstrap + ' and ' + jquery;
    html += '. Created by ' + me + '.<hr class=\'my-4\'>';
    html += 'Use navigation bar given at the top to explore this website.</p>';
    $('#sayhello').html(html);
    $('#sayhello').css({'display' : '', 'background-color' : '#fff', 'color' : '#000'});
}

// ajax call for getting quotes from a rest api
document.addEventListener("DOMContentLoaded", function (){
  // old api: https://api.quotable.io/random
  $.get("https://quotes.rest/qod", function (data) {
    if (data) {
      var content = data.contents.quotes[0].quote;
      var author = data.contents.quotes[0].author;
      var html = "";
      html = "<p>" + content + "</p>";
      html += "<p class=\"text-right\" style=\"color: #292b2c; font-weight: 500;\"> - " + author + "</p>";
      document.getElementById("quote").innerHTML = html;
    }
  });
});