
$(document).ready(function(){

    news1 = {
        "header":"News Title 1",
        "text":"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    };
    news2 = {
        "header":"News Title 2",
        "text":"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    };


    $("#newscontent").html(
        '<h5>' + news1.header + '</h5>' +
        '<p>' + news1.text + '</p></br>' +
        '<h5>' + news2.header + '</h5>' +
        '<p>' + news2.text + '</p></br>'
    );
});