/*

Here are a few RA stories, encoded in a format we want to use in the upcoming version of RA web and the content production tool. The idea is that it is not paginated in advance. The way it looks will depend on the dimension of book pages, which can differ depending on device of browser window sizes.

A story is a JavaScript Object that includes a title and a block list. These blocks are different from the HTML concept of block, we call them Zhiyong blocks (or zh-block) to avoid confusions.

A zh-block is a piece of content that must appear on one single book page. It can be for example a piece of text that must be right above or below an image, or a small paragraph that we don't want to see spanning several pages.

Each block is itself a JavaScript object. Each block has a list of classes which describe the style of its content. In addition, a block has a list of content. Again, all its content must be rendered on one book page. We call each item in the content list a content item.

A content item has one type field which is either a sentence or an image ("img"). It can also have classes, which apply only on that content item.
If a content item is an image, then it also has a "src" field which is the URL of the image. If the content item is a sentence, there is a content field which is the sentence string. In the content of a sentence will be an array of words.

The blocks are rendered in order, and in each block, the content items are also displayed in order. The content is rendered page by page. Once a block is inserted and overflows the page, then it is removed, a new page is created and the content is appened to the new page.

Both blocks and block items can also have a margin field. If true, then there is a margin at the end of the block or item.

The meaning of the different classes can be seen in the CSS.

*/

//{type: "sentence", content: []},
//{w:"",s:""},

var aCubsLife = { title: "A Cub&#39;s life",
		  blocks: [
		      { classes: ["zh-block", "zh-block-br"],
			content: [ {type: "sentence", content: [{w:"A",s:" "},{w:"new",s:" "},{w:"day",s:" "},{w:"begins",s:"."}], br: true},
				   {type: "sentence", content: [{w:"A",s:" "},{w:"leopard",s:" "},{w:"cub",s:" "},{w:"wakes",s:" "},{w:"up",s:"."}], br: true},
				   {type: "img", src: "a-cubs-life-img-5.jpg", classes: ["img-margins"], width: 238, height: 128} ] },
		      { classes: ["zh-block", "zh-block-br"],
			content: [ {type: "sentence", content: [{w:"The",s:" "},{w:"cub",s:" "},{w:"gets",s:" "},{w:"a",s:" "},{w:"bath",s:"."}], br: true},
				   {type: "sentence", content: [{w:"Now",s:" "},{w:"he",s:" "},{w:"is",s:" "},{w:"ready",s:" "},{w:"to",s:" "},{w:"play",s:"."}], br: true},
				   {type: "img", src: "a-cubs-life-img-2.jpg", classes: ["img-margins"], width: 305, height: 207} ] },
		      { classes: ["zh-block", "zh-block-br"],
			content: [ {type: "sentence", content: [{w:"The",s:" "},{w:"cub",s:" "},{w:"finds",s:" "},{w:"a",s:" "},{w:"friend",s:"."}], br: true},
				   {type: "sentence", content: [{w:"The",s:" "},{w:"friends",s:" "},{w:"play",s:" "},{w:"in",s:" "},{w:"a",s:" "},{w:"tree",s:"."}], br: true},
				   {type: "img", src: "a-cubs-life-img-3.jpg", classes: ["img-margins"], width: 296, height: 195} ] } ]
		};

var notSoStarryNights = {
    title: "Not-So-Starry Nights",
    blocks: [
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin"],
	  content: [ {type: "img", src: "not-so-starry-nights-img-1.jpg", width: 295, height: 245 } ] },
	{ classes: ["zh-block"],
	  content: [
	      { type: "sentence", content: [{w:"The",s:" "},{w:"Sky",s:" "},{w:"as",s:" "},{w:"a",s:" "},{w:"Natural",s:" "},{w:"Resource"}], classes: ["zh-sentence-title"], margin: true},
	      { type: "sentence", content: [{w:"A",s:" "},{w:"star-filled",s:" "},{w:"sky",s:" "},{w:"is",s:" "},{w:"a",s:" "},{w:"magnificient",s:" "},{w:"sight",s:"."}], classes: ["sentence-start-paragraph"] }
	  ] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: [{w:"It",s:" "},{w:"is",s:" "},{w:"also",s:" "},{w:"an",s:" "},{w:"important",s:" "},{w:"part",s:" "},{w:"of",s:" "},{w:"our",s:" "},{w:"lives",s:"."}]}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: [{w:"By",s:" "},{w:"studying",s:" "},{w:"the",s:" "},{w:"sky",s:", "},{w:"we",s:" "},{w:"learn",s:" "},{w:"about",s:" "},{w:"our",s:" "},{w:"place",s:" "},{w:"in",s:" "},{w:"the",s:" "},{w:"universe",s:"."}]}] },
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{ type: "sentence", content: [{w:"Animals",s:" "},{w:"also",s:" "},{w:"need",s:" "},{w:"the",s:" "},{w:"night",s:" "},{w:"sky",s:"."}]}] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: [{w:"Some",s:" "},{w:"animals",s:" "},{w:"use",s:" "},{w:"the",s:" "},{w:"stars",s:" "},{w:"to",s:" "},{w:"find",s:" "},{w:"their",s:" "},{w:"way",s:"."}]}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: [{w:"Others",s:" "},{w:"depend",s:" "},{w:"on",s:" "},{w:"the",s:" "},{w:"dark",s:" "},{w:"to",s:" "},{w:"feel",s:" "},{w:"safe",s:"."}]}] },
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{ type: "sentence", content: [{w:"This",s:" "},{w:"natural",s:" "},{w:"wonder",s:", "},{w:"like",s:" "},{w:"many",s:" "},{w:"others",s:", "},{w:"is",s:" "},{w:"in",s:" "},{w:"danger",s:" "},{w:"from",s:" "},{w:"human",s:" "},{w:"activity",s:"."},]}] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: [{w:"Light",s:" "},{w:"pollution",s:" "},{w:"is",s:" "},{w:"changing",s:" "},{w:"our",s:" "},{w:"view",s:" "},{w:"of",s:" "},{w:"the",s:" "},{w:"night",s:"."},]}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: [{w:"We",s:" "},{w:"must",s:" "},{w:"change",s:" "},{w:"our",s:" "},{w:"ways",s:", "},{w:"or",s:" "},{w:"we",s:" "},{w:"will",s:" "},{w:"lose",s:" "},{w:"the",s:" "},{w:"benefits",s:" "},{w:"of",s:" "},{w:"the",s:" "},{w:"starry",s:" "},{w:"sky",s:"."}]}] },
	{ classes: ["zh-block"],
	  content: [
	      { type: "sentence", content: [{w:"History",s:" "},{w:"of",s:" "},{w:"the",s:" "},{w:"problem"}], classes: ["zh-sentence-title"], margin: true},
	      { type: "sentence", content: [{w:"One",s:" "},{w:"hundred",s:" "},{w:"years",s:" "},{w:"ago",s:", "},{w:"everyone",s:" "},{w:"had",s:" "},{w:"a",s:" "},{w:"twinkling",s:" "},{w:"view",s:" "},{w:"of",s:" "},{w:"the",s:" "},{w:"night",s:" "},{w:"sky",s:"."}], classes: ["sentence-start-paragraph"] }
	  ] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: [{w:"At",s:" "},{w:"that",s:" "},{w:"time",s:", "},{w:"people",s:" "},{w:"could",s:" "},{w:"see",s:" "},{w:"about",s:" "},{w:"1,500",s:" "},{w:"stars",s:"."}]}] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: [{w:"Today",s:", "},{w:"only",s:" "},{w:"one",s:" "},{w:"in",s:" "},{w:"ten",s:" "},{w:"Americans",s:" "},{w:"has",s:" "},{w:"a",s:" "},{w:"beautiful",s:", "},{w:"starry",s:" "},{w:"view",s:"."}]}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: [{w:"People",s:" "},{w:"in",s:" "},{w:"cities",s:" "},{w:"see",s:" "},{w:"a",s:" "},{w:"glowing",s:" "},{w:"orange",s:" "},{w:"sky",s:" "},{w:"and",s:" "},{w:"just",s:" "},{w:"a",s:" "},{w:"few",s:" "},{w:"dozen",s:" "},{w:"stars",s:" "},{w:"instead",s:"."}]}] }
    ]
};





var stories = [aCubsLife, notSoStarryNights];





/*

















var greatPresidentialSpeeches = { title: "Great Presidential Speeches",
				  blocks: [ 
				      { classes: ["zh-block", "floating-img-left"],
					content: [ {type: "img", classes: ["floating-img-left"], src: "great-presidential-speeches-img-1.jpg", width: 121, height: 150} ] },
				      { classes: ["zh-block", "zh-block-start-paragraph"],
					content: [{type: "sentence", content: "When George Washington pledged during his first inaugural address to protect the new nation&#39;s &ldquo;liberties and freedoms&rdquo; under &ldquo;a government instituted by themselves,&rdquo; he launched a long tradition of great presidential speeches."}],
					margin: true},
				      { classes: ["zh-block", "zh-block-start-paragraph"],
					content: [{type: "sentence", content: "America&#39;s first president later concluded his term in office with a much-admired, moving Farewell Address."} ] },
				      { classes: ["zh-block"],
					content: [{type: "sentence", content: "Although it is by all accounts the most famous and best-known of his speeches, it was never actually delivered orally by Washington."}] },
				      { classes: ["zh-block"],
					margin: true,
					content: [{type: "sentence", content: "By his own arrangement, it first appeared in a newspaper in Philadelphia."}] },
				      { classes: ["zh-block", "zh-block-start-paragraph"],
					content: [{type: "sentence", content: "Washington took office during the birth of the nation, and his speeches tended to be moving, thoughtful pieces about the values of the new country."}] },
				      { classes: ["zh-block"],
					content: [{type: "sentence", content: "Franklin Delano Roosevelt, however, was president during one of the most difficult times in America&#39;s history."}] },
				      { classes: ["zh-block"],
					content: [{type: "sentence", content: "Taking office in the middle of the Great Depression, Roosevelt outlined his plans for recovery in a rousing speech that declared:"}] },
				      { classes: ["zh-block"],
					margin: true,
					content: [{type: "sentence", content: "&ldquo;the only thing we have to fear is fear itself.&rdquo; He delivered this unforgettable line in the first paragraph of his speech:"}] },
				      { classes: ["zh-block", "quotation"],
					indented: "quotation",
					content: [{type: "sentence", content: "I am certain that my fellow Americans expect that on my induction into the Presidency I will address them with a candor and a decision which the present situation of our Nation impels."}] },
				      { classes: ["zh-block", "quotation"],
					indented: "quotation",
					content: [{type: "sentence", content: "This is preeminently the time to speak the truth, the whole truth, frankly and boldly."}] },
				      { classes: ["zh-block", "quotation"],
					indented: "quotation",
					content: [{type: "sentence", content: "Nor need we shrink from honestly facing conditions in our country today."}] },
				      { classes: ["zh-block", "quotation"],
					indented: "quotation",
					content: [{type: "sentence", content: "This great Nation will endure as it has endured, will revive and will prosper."}] },
				      { classes: ["zh-block", "quotation"],
					margin: true,
					indented: "quotation",
					content: [{type: "sentence", content: "So, first of all, let me assert my firm belief that the only thing we have to fear is fear itself—nameless, unreasoning, unjustified terror which paralyzes needed efforts to convert retreat into advance."}] },
				      { classes: ["zh-block", "zh-block-start-paragraph"],
					content: [{type: "sentence", content: "John F. Kennedy is considered one of the greatest presidential orators of the 20th Century."}] },
				      { classes: ["zh-block"],
					margin: true,
					content: [{type: "sentence", content: "Short but memorable, Kennedy&#39;s 1961 Inaugural Address exhorted American citizens to &ldquo;ask not what your country can do for you—ask what you can do for your country.&rdquo;"}] } ] };

var notSoStarryNights = {
    title: "Not-So-Starry Nights",
    blocks: [
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin"],
	  content: [ {type: "img", src: "not-so-starry-nights-img-1.jpg", width: 295, height: 245 } ] },
	{ classes: ["zh-block"],
	  content: [
	      { type: "sentence", content: "The Sky as a Natural Resource", classes: ["zh-sentence-title"], margin: true},
	      { type: "sentence", content: "A star-filled sky is a magnificent sight.", classes: ["sentence-start-paragraph"] }
	  ] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: "It is also an important part of our lives."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: "By studying the sky, we learn about our place in the universe."}] },
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{ type: "sentence", content: "Animals also need the night sky."}] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: "Some animals use the stars to find their way."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: "Others depend on the dark to feel safe."}] },
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{ type: "sentence", content: "This natural wonder, like many others, is in danger from human activity."}] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: "Light pollution is changing our view of the night."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: "We must change our ways, or we will lose the benefits of the starry sky."}] },
	{ classes: ["zh-block"],
	  content: [
	      { type: "sentence", content: "History of the Problem", classes: ["zh-sentence-title"], margin: true},
	      { type: "sentence", content: "One hundred years ago, everyone had a twinkling view of the night sky.", classes: ["sentence-start-paragraph"] }
	  ] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: "At that time, people could see about 1,500 stars."}] },
	{ classes: ["zh-block"],
	  content: [{ type: "sentence", content: "Today, only one in ten Americans has a beautiful, starry view."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{ type: "sentence", content: "People in cities see a glowing orange sky and just a few dozen stars instead."}] }
    ]
};

var seaFever = {
    title: "Sea Fever",
    blocks: [
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "I must go down to the seas again, to the lonely sea and the sky,"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "And all I ask is a tall ship and a star to steer her by,"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "And the wheel&#39;s kick and the wind&#39;s song and the white sail&#39;s shaking,"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block", "zh-block-br-margin"],
	  content: [{type: "sentence", content: "And a grey mist on the sea&#39;s face and a grey dawn breaking."}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin"],
	  content: [ {type: "img", src: "sea-fever-img-1.jpg", width: 207, height: 382} ] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "I must go down to the seas again, for the call of the running tide"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "Is a wild call and a clear call that may not be denied;"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "And all I ask is a windy day with the white clouds flying,"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block", "zh-block-br-margin"],
	  content: [{type: "sentence", content: "And the flung spray and the blown spume, and the sea-gulls crying."}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "I must go down to the seas again, to the vagrant gypsy life,"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "To the gull&#39;s way and the whale&#39;s way where the wind&#39;s like a whetted knife;"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block"],
	  content: [{type: "sentence", content: "And all I ask is a merry yarn from a laughing fellow-rover,"}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin", "poetry-sentence-block", "zh-block-br-margin"],
	  content: [{type: "sentence", content: "And quiet sleep and a sweet dream when the long trick&#39;s over."}] }
    ]   
};


var whosOnFirst = {
    title: "Who&#39;s on First",
    blocks: [
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{type: "sentence", content: "Abbott and Costello were a popular comedy team	who performed in the late 1930s through the 1950s."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{type: "sentence", content: "William &ldquo;Bud&rdquo; Abbott and Lou Costello appeared together on radio, television, in movies, and in live performances."}] },
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{type: "sentence", content: "Their most popular comedy routine was &ldquo;Who&#39;s on First?&rdquo;"}] },
	{ classes: ["zh-block"],
	  content: [{type: "sentence", content: "In this routine, Abbott plays the role	of a baseball team manager in New York."}] },
	{ classes: ["zh-block"],
	  content: [{type: "sentence", content: "Costello is getting a job with the team, but first needs to learn the names of the players."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{type: "sentence", content: "The humor in the comedy piece comes from the names of the players and Costello&#39;s confusion as he tries to learn them from Abbott."}] },
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin"],
	  content: [ {type: "img", src: "whos-on-first-img-1.jpg", width: 205, height:  216} ] },
	{ classes: ["zh-block", "zh-block-start-paragraph"],
	  content: [{type: "sentence", content: "This famous routine is part of comedy lore, but also part of baseball lore."}] },
	{ classes: ["zh-block"],
	  margin: true,
	  content: [{type: "sentence", content: "The Baseball Hall of Fame in Cooperstown, New York has an entire exhibit dedicated to Abbott and Costello&#39;s &ldquo;Who&#39;s on First?&rdquo;"}] },
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Abbott:</span> Well, Costello, I&#39;m going to New York with you."}] },
	{ classes: ["zh-block"],
	  indented: "dialog",
	  margin: true,
	  content: [{type: "sentence", content: "The manager gave me a job as coach for as long as you&#39;re on the team."}] },
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Costello:</span> Look Abbott, if you&#39;re going to be the coach, you must know all the players."}] },
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Abbott:</span> I certainly do."}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Costello:</span> Well, you know, I&#39;ve never met the guys."}]},
	{ classes: ["zh-block"],
	  indented: "dialog",
	  margin: true,
	  content: [{type: "sentence", content: "So you&#39;ll have to tell me their names, and then I&#39;ll know who&#39;s playing on the team."}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Abbott:</span> Oh, I&#39;ll tell you their names, but you	know it seems to me they give these ball players nowadays very peculiar names."}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Costello:</span> You mean funny names?"}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Abbott:</span> Yes, strange names, nicknames, you	know&hellip;"}]},
	{ classes: ["zh-block"],
	  indented: "dialog",
	  content: [{type: "sentence", content: "Well, let&#39;s see, we have on the bases&ndash;"}]},
	{ classes: ["zh-block"],
	  indented: "dialog",
	  margin: true,
	  content: [{type: "sentence", content: "Who&#39;s on first, What&#39;s on second, I Don&#39;t Know is on third&hellip;"}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Costello:</span> That&#39;s what I want to find out."}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Abbott:</span> I said Who&#39;s on first, What&#39;s on second, I Don&#39;t Know&#39;s on third&hellip;"}]},
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Costello:</span> Are you the manager?"}]},
	{ classes: ["zh-block", "zh-block-br", "zh-block-br-margin"],
	  content: [ {type: "img", src: "whos-on-first-img-2.jpg", width: 191, height: 229} ] },
	{ classes: ["zh-block"],
	  indented: "dialog-start",
	  margin: true,
	  content: [{type: "sentence", content: "<span class=\"speaker-name\">Abbott:</span> Yes."}]},
    ]
};

var stories = [aCubsLife, greatPresidentialSpeeches, notSoStarryNights, seaFever, whosOnFirst];
*/
