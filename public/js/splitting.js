(function(window) {
    var RAParser = function() {
	var specialWordsReg = /^[\.\,\'\"\;\:\?\!\$\%\&\(\)\ \-\‘\’\“\”\…]*(Dr\.|Mr\.|U\.S\.A\.|U\.S\.)[\.\,\'\"\;\:\$\%\&\(\)\ \-\‘\’\“\”\…]*$/;
	var isSentenceEnd = function(input) {
	    return ((input.match(/(\.|\!|\?|\…|\n)[\.\,\'\"\;\:\?\!\$\%\&\(\)\ \-\“\”\…\‘\’\n]*$/)) &&
		    (!(input.match(specialWordsReg))));
	};
	var invalidCharactersRe = /[^a-zA-Z0-9\.\,\'\"\;\:\?\!\$\%\&\(\)\ \-\“\”\…\‘\’\n]/g;
	var preProcess = function(input) {
	    return input.replace(/\t/g," ").replace(/\r/g, "");
	};
	var splitWords = function(input) {
	    return input.match(/[^ \n]+( |\n|$)/gm);
	};
	var buildSentences = function(input) {
	    var output = [];
	    var currentSentence = [];
	    for (var i = 0 ; i< input.length ; i++) {
		currentSentence.push(input[i]);
		if (isSentenceEnd(input[i]) || (i == (input.length - 1))) {
		    output.push(currentSentence);
		    currentSentence = [];
		}
	    }
	    return output;	
	};
	this.parse = function(input) {
	    var sentences = [];
	    input = preProcess(input);
	    var output = parseInvalidChars(input);
	    if (!output) sentences = buildSentences(splitWords(input));
	    return sentences
	};
	var parseInvalidChars = function(input) {
	    return input.match(invalidCharactersRe);
	};
    };
    window.RAParser = RAParser;
})(window);
