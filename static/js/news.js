
$(document).ready(function(){
    var newsfield = '';
    $.getJSON("custom/js/news.json", function(json) {
        text = JSON.stringify(json);
        var obj = JSON.parse(text);
        for (i=0; i < obj.news.length; i++) {
            newsfield = newsfield + '<h5>' + obj.news[i].header + '</h5><p>' + obj.news[i].text + '</p></br>';
        }
        $("#newscontent").html(newsfield);
    });
});
