/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var backgrounds = new Array(
    "background1",
    "background2",
	"background3",
	"background4",
	"background5"
);

var lefts = new Array(
    "manLeft1",
	"manLeft2",
	"manLeft3",
	"manLeft4"
);

var rights = new Array(
    "manRight1",
	"manRight2",
	"manRight3",
	"manRight4"
);

var questions = new Array(
	"Why do hot dogs come in packages of 10 and hot dog buns come in packages of 12?",
	"Why is my life so full of despair?",
	"Is it illegal to drive through an intersection backwards?",
	"I wonder if i’m an immediate suspect?",
	"Who monitors these?",
	"Is it Amdahl’s Law?",
	"Can I have more paper?",
	"Who put that comment there?",
	"If a tree falls in the forest and no one hears.  Does it make a sound?"
);

var answers = new Array(
	"If you read a book for once you would understand.",
	"Many great philosophers have pondered that question.",
	"When did this become a valid concern?",
	"That’s just a cron job",
	"It’s a perl script.",
	"I feel for those people.",
	"Using an eval() is like picking up something off the ground and putting it in your mouth",
	"That solution can only be found through the use of lego",
	"Forty-Two",
	"I think you need another energy drink"
);

var punchlines = new Array(
	"Bro do you even lift?",
	"I knew I should have brought my tool box.",
	"Dude, you have cobol programmer written all over you.",
	"Prove it.",
	"The Germans have discovered PHP",
	"There’s parts that aren’t really structured.",
	"English for Engineers.",
	"It started with a lot of positive.",
	"We’re running this Ohaton style.",
	"This almost makes conversational sense.",
	"You smell nice",
	"I think we need to make a Venn Diagram"
);

var decorations = [
    
];

var c1;
var ctx1;

function drawComic(seed, step) {
    c1 = document.getElementById("comic-canvas1");
    ctx1 = c1.getContext("2d");
	// Clear the canvas
	ctx1.clearRect(0, 0, c1.width, c1.height);
    
    if (step >= 1) {
        drawBackground(seed);
    }
    if (step >= 2) {
        drawManLeft(seed);
    }
    if (step >= 3) {
        drawManRight(seed);
    }
    if (step >= 4) {
        writeQuestion(seed);
    }
    if (step >= 5) {
        writeAnswer(seed);
    }
    if (step >= 6) {
        writePunchline(seed);
    }
}


function drawBackground(seed) {
	var c = new Chance(seed);
    var bgImage = c.pick(backgrounds);
	var bg = document.getElementById(bgImage);
	ctx1.drawImage(bg,0,200);
}

function drawManLeft(seed){
	var c = new Chance(seed);
	var manLeft = c.pick(lefts);
	var ml = document.getElementById(manLeft);
	ctx1.drawImage(ml,100,100);
}

function drawManRight(seed){
	var c = new Chance(seed);
	var manRight = c.pick(rights);
	var mr = document.getElementById(manRight);
	ctx1.drawImage(mr,500,100);
}

function writeQuestion(seed){
	var c = new Chance(seed);
	var question = c.pick(questions);
	ctx1.beginPath();
	ctx1.moveTo(200, 100);
	ctx1.lineTo(300, 35);
	ctx1.stroke();
	ctx1.textAlign="start";
	ctx1.font="10px Verdana";
	ctx1.fillText(question, 300, 30);
}

function writeAnswer(seed){
	var c = new Chance(seed);
	var answer = c.pick(answers);
	ctx1.beginPath();
	ctx1.moveTo(550, 100);
	ctx1.lineTo(550, 50);
	ctx1.stroke();
	ctx1.textAlign="end";
	ctx1.font="10px Verdana";
	ctx1.fillText(answer, 600, 45);
}

function writePunchline(seed){
	var c = new Chance(seed);
	var punchline = c.pick(punchlines);
	ctx1.beginPath();
	ctx1.moveTo(210, 100);
	ctx1.lineTo(320, 65);
	ctx1.stroke();
	ctx1.textAlign="start";
	ctx1.font="10px Verdana";
	ctx1.fillText(punchline, 300, 60);
}
