
var getCheckedValue = function(radioGroupName) {
    var rads = document.getElementsByName(radioGroupName), j;
    for (j=0; j < rads.length; j++) if (rads[j].checked) return rads[j].value;
};
var fontMap = ["tnr", "g", "a", "v", "cn", "lc"];

var applyWords = function() {
    $('.word.ui-selected').removeClass('small normal large font-tnr font-g font-a font-v font-cn font-lc italic bold');
    $('.word.ui-selected').addClass(getCheckedValue('word-text-size'));
    if ($('#word-bold')[0].checked) $('.word.ui-selected').addClass('bold');
    if ($('#word-italic')[0].checked) $('.word.ui-selected').addClass('italic');
    $('.word.ui-selected').addClass('font-' + fontMap[$('#word-font')[0].selectedIndex]);
};

var applySentences = function() {
    if  ($('.word.ui-selected').length) {
	var sentences = $('.word.ui-selected').parent();
	sentences.removeClass('small normal large font-tnr font-g font-a font-v font-cn font-lc italic bold');
	sentences.addClass(getCheckedValue('sentence-text-size'));
	if ($('#sentence-bold')[0].checked) sentences.addClass('bold');
	if ($('#sentence-italic')[0].checked) sentences.addClass('italic');
	sentence.addClass('font-' + fontMap[$('#sentence-font')[0].selectedIndex]);
    }
};

var applyParagraphs = function() {
    var paragraphId = $('.word.ui-selected').parent().attr('class').match(/paragraph-\d+/);
    if (paragraphId && paragraphId[0]) {
	var paragraph = $('.' + paragraphId);
	paragraph.removeClass('small normal large font-tnr font-g font-a font-v font-cn font-lc italic bold');
	paragraph.addClass(getCheckedValue('paragraph-text-size'));
	if ($('#paragraph-bold')[0].checked) paragraph.addClass('bold');
	if ($('#paragraph-italic')[0].checked) paragraph.addClass('italic');
	paragraph.addClass('font-' + fontMap[$('#paragraph-font')[0].selectedIndex]);
    }
};

$(function() {
    $( "#ra-web-page" ).selectable({
	start: function(event, ui) {
	    $('.sentence').removeClass('sentence-selected sentence-selecting paragraph-selected');
	},
	selecting: function ( event, ui ) {
	    $('.sentence').removeClass('sentence-selected sentence-selecting paragraph-selected');
	    if  ($('.word.ui-selecting').length) {
		$('.word.ui-selecting').parent().addClass('sentence-selecting');
		$('.word.ui-selected').parent().addClass('sentence-selected');
	    }
	},
	stop: function() {
	    $('.sentence').removeClass('sentence-selected sentence-selecting paragraph-selected');
	    if ($('.word.ui-selected').length) {
		$('.word.ui-selected').parent().addClass('sentence-selected');
		var paragraphId = $('.word.ui-selected').parent().attr('class').match(/paragraph-\d+/);
		if (paragraphId && paragraphId[0]) $('.' + paragraphId).addClass('paragraph-selected');  
	    }
	}
    });
});
