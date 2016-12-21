
$(document).ready(function(){

    potw = {
        "picurl":"/custom/img/potw/pictureoftheweek.jpeg",
        "dealurl":"http://localhost:6543/activities/html/cc4091e4-8800-48ae-a9a6-3a1406844a4f",
        "text":"Headline"
    };


    $("#bottom-tab1").html(
        '<p style="margin-top: 20px; margin-bottom: 10px; font-weight: bold;">' + potw.text + '</p>' +
        '<a href="' + potw.dealurl + '">' +
            '<img src="' + potw.picurl + '" id="img-weekpicture">' +
        '</a>'
    );
});