
$(document).ready(function(){

    var potw = '';
    $.getJSON("http://mmlandreporting.info/potw.json", function(json) {
        text = JSON.stringify(json);
        var obj = JSON.parse(text);
        $("#bottom-tab1").html(
            '<p style="margin-top: 20px; margin-bottom: 10px; font-weight: bold;">' + obj.text + '</p>' +
            '<a href="' + obj.dealurl + '">' +
                '<img src="' + obj.picurl + '" id="img-weekpicture">' +
            '</a>'
        );
    });
});