(function(window) {
    var RenderingEngine = function() {
	var checkBoxString = "<input type=\"checkbox\"/>";
	var webPage = document.getElementById('ra-web-page');
	var getCheckedValue = function(radioGroupName) {
	    var rads = document.getElementsByName(radioGroupName), j;
	    for (j=0; j < rads.length; j++) if (rads[j].checked) return rads[j].value;
	};
	var getHeight = function() {
	    return getCheckedValue('bpageh');
	};
	var getWidth = function() {
	    return getCheckedValue('bpagew');
	};
	var getNumPages = function() {
	    return getCheckedValue('bpage');
	};
	var getFontSize = function() {
	    return getCheckedValue('bpagef');
	};
	var appendPage = function() {
	    var newPageContainer = document.createElement('div');
	    newPageContainer.className = "book-page-container";
	    webPage.appendChild(newPageContainer);
	    var newPage = document.createElement('div');
	    newPage.className = getWidth() + "-pagew " + getHeight() + "-pageh book-page";
	    newPageContainer.appendChild(newPage);
	    var newPageSide = document.createElement('div');
	    newPageSide.className = "book-page-side";
	    newPageContainer.appendChild(newPageSide);
	    return {left: newPage, right: newPageSide};
	};
	var getPannelClass = function(type) {
	    if (type == "quotation") return "quotation-pannel";
	    if (type == "dialog-start") return "dialog-pannel-start";
	    if (type == "dialog") return "dialog-pannel";
	    return "";
	};
	var getPannelTypeMin = function(type) {
	    if (type == "dialog-start") return "dialog";
	    return type;
	};
	var appendPannel = function(page, type) {
	    var newPannel = document.createElement('div');
	    newPannel.className = getPannelClass(type);
	    page.appendChild(newPannel);
	    return newPannel;
	};
	var clearWebPage = function() {
	    webPage.innerHTML = "";   
	};
	var resetStyle = function() {
	    webPage.className = "book-pages-fonts-" + getFontSize();
	};
	var overFlows = function(container) {
            return (container.offsetHeight < (container.scrollHeight + 4));
	};
	this.render = function() {
	    clearWebPage();
	    resetStyle();
	    var paragraphIndex = 0;
	    var blockBr = false;
	    var sentenceBr = false;
	    var currentPannelType = "normal";
	    var data = stories[document.getElementById('stories').selectedIndex].blocks.slice(0);
	    var doublePage = appendPage();
	    var currentPage = doublePage.left;
	    var currentPageSide = doublePage.right;
	    var currentPannel = appendPannel(currentPage);
	    while (data.length > 0) {
		var block = data.shift();
		var newElt, newEltSide, blockCheckBox, newEltSideContainer, blockCheckBoxContainer;
		var newPannelType = "normal";
		blockBr = (block.classes.indexOf("zh-block-br") > -1) || block.margin;
		if (block.indented) newPannelType = block.indented;
		var newPannelTypeMin = getPannelTypeMin(newPannelType);
		if ((newPannelTypeMin != currentPannelType) || (newPannelType == "dialog-start")) {
		    var currentPannel = appendPannel(currentPage, newPannelType);
		    currentPannelType = newPannelTypeMin;
		}
		newElt = document.createElement('span');
		newEltSide = document.createElement('div');
		newEltSide.className = "side-block"; 
		blockCheckBox = document.createElement('input');
		blockCheckBox.type = "checkbox";
		blockCheckBox.className = "side-checkbox";
		blockCheckBoxContainer = document.createElement('div');
		blockCheckBoxContainer.className = "side-checkbox-container";
		blockCheckBoxContainer.appendChild(blockCheckBox);
		newEltSideContainer = document.createElement('div');
		newEltSideContainer.className = "side-container";
		newEltSide.appendChild(blockCheckBoxContainer);
		newEltSide.appendChild(newEltSideContainer);
		newElt.className = block.classes.join(" ");
		for (var i = 0 ; i < block.content.length ; i++) {
		    var childElt;
		    var childEltSide;
		    childEltSide =  document.createElement('div');
		    childEltSide.className = "side-item";
		    if (block.content[i].type == "sentence") {
			sentenceBr = block.content[i].br || 
			    block.content[i].margin || 
			    (block.content[i].classes && 
			     (block.content[i].classes.indexOf("zh-sentence-title") > -1));
			childElt =  document.createElement('span');
			for (var j = 0 ; j < block.content[i].content.length ; j++) {
			    if (block.content[i].content[j].p) {
				var prefix = document.createTextNode(block.content[i].content[j].p);
				var prefixSide = document.createTextNode(block.content[i].content[j].p);
				childElt.appendChild(prefix);
				childEltSide.appendChild(prefixSide);
			    }
			    if (block.content[i].content[j].w) {
				var word = document.createElement('span');
				word.className = "word";
				word.innerHTML = block.content[i].content[j].w;
				var wordSide = document.createElement('span');
				wordSide.className = "word";
				wordSide.innerHTML = block.content[i].content[j].w;
				childElt.appendChild(word);
				childEltSide.appendChild(wordSide);
			    }
			    if (block.content[i].content[j].s) {
				var suffix = document.createTextNode(block.content[i].content[j].s);
				var suffixSide = document.createTextNode(block.content[i].content[j].s);
				childElt.appendChild(suffix);
				childEltSide.appendChild(suffixSide);
			    }
			}
			var sentenceEnd = block.content[i].br ? document.createElement('br') : document.createTextNode(" ");
			var sentenceEndSide = block.content[i].br ? document.createElement('br') : document.createTextNode(" ");
//			var space = document.createTextNode(" ");
			childElt.appendChild(sentenceEnd);
			childEltSide.appendChild(sentenceEndSide);
			childElt.className = "sentence editable paragraph-" + paragraphIndex;
			if (sentenceBr) paragraphIndex++;
			//childEltSide.innerHTML = checkBoxString + "<span class=\"editable\">" +block.content[i].content + "</span>";
		    } else if (block.content[i].type == "img") {
			childElt =  document.createElement('img');
			childElt.src = "img/" + block.content[i].src;
			childEltSide.innerHTML = checkBoxString + block.content[i].src;
			childEltSide.className += " image-input";
			if (block.content[i].width)
			    childElt.style.width = "" + block.content[i].width + "px";
			if (block.content[i].height)
			    childElt.style.height = "" + block.content[i].height + "px";
		    }
		    if (block.content[i].classes && (block.content[i].classes.length > 0))
			childElt.className += " " + block.content[i].classes.join(" ");
		    if (block.content[i].margin)	
			childElt.innerHTML += "<br/><br/>";
		    if (blockBr && !(sentenceBr)) paragraphIndex++;
		    newEltSideContainer.appendChild(childEltSide);
		    newElt.appendChild(childElt);
		}

		currentPannel.appendChild(newElt);
		currentPageSide.appendChild(newEltSide);
		if (overFlows(currentPage)) {
		    currentPannel.removeChild(currentPannel.lastChild);
		    currentPageSide.removeChild(currentPageSide.lastChild);
		    doublePage = appendPage();
		    currentPage = doublePage.left;
		    currentPageSide = doublePage.right;
		    currentPannel = appendPannel(currentPage, newPannelType);
		    currentPannel.appendChild(newElt);
		    currentPageSide.appendChild(newEltSide);
		}
		if (block.margin) newElt.innerHTML += "<br/><br/>";

	    }
/*
	    $('.editable').raptor({
                "plugins": {
                    "dock": {
                        "docked": true
                    }
                }
            });
*/
	};
    };
    window.RenderingEngine = RenderingEngine;
})(window);
