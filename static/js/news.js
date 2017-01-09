
$(document).ready(function(){
    var newsfield = '';
    $.getJSON("http://mmlandreporting.info/news.json", function(json) {
        text = JSON.stringify(json);
        var obj = JSON.parse(text);
        for (i=0; i < obj.news.length; i++) {
            newsfield = newsfield + '<h1>' + obj.news[i].header + '</h1><p>' + obj.news[i].text + '</p>';
        }
        $("#newscontent").html(newsfield);
    });
});