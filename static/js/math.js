/* Start of game set-up */
$(window).load(function() {
	window.game = {
		'seed': $("#game-seed").attr("content"),
		'question': 1,
		'timer': 120,
		'timer_started': false,
		'start': 0,
		'types': JSON.parse($("#game-types").attr("content")),
		'question_seed': function(){
			var c = new Chance(this.seed);
			var i, n;
			for (i = 0; i < this.question; i++) {
				n = c.random();
			}
			return Math.floor(n*10000000);
		},
		'show_math': function(){
			$('#loader').hide();
			$('#math').show();
		},
		'hide_math': function(){
			$('#math').hide();
			$('#loader').show();
		},
		'load_question': function(){
			var c = new Chance(this.question_seed());
			var qtype = this.types[Math.floor(c.random()*1000) % this.types.length];
			$.ajax('/math/' + qtype + '/' + this.question_seed(), {
				dataType: 'json',
				error: function(jqx, stat, err) {
					console.error("Failed to load question.");
				},
				success: function(data, status, jqx) {
					$('#question').html("$$" + data.latex + "$$");
					$('#answer').html('<textarea id="formula1" name="formula1" class="mathdoxformula"></textarea>');
					var textarea = document.getElementById("formula1");
					org.mathdox.formulaeditor.FormulaEditor.updateByTextAreas(textarea);
					org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea(textarea).focus();
					MathJax.Hub.Typeset(document.getElementById("question"), game.show_math());
					game.start_timer();
				}
			});
		},
		'check_answer': function(){
			var c = new Chance(this.question_seed());
			var qtype = this.types[Math.floor(c.random()*1000) % this.types.length];
			$.ajax('/math/' + qtype + '/' + this.question_seed() + '/check/', {
				type: 'POST',
				dataType: 'json',
				headers: {'X-CSRFToken': $.cookie('csrftoken')},
				data: {
					'input': org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea("formula1").getMathML()
				},
				error: function(jqx, stat, err) {
					console.error("Failed to check answer.");
				},
				success: function(data, status, jqx) {
					if (data.correct == false) {
						$("#incorrect-answer").show();
						var textarea = document.getElementById("formula1");
						org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea(textarea).focus();
					} else {
						game.hide_math();
						$("#question").html("");
						$("#incorrect-answer").hide();
						game.question += 1;
						game.load_question();
					}
				}
			});
		},
		'start_timer': function(){
			if (!this.timer_started) {
				this.timer_started = true;
				this.reset_timer();
			}
		},
		'reset_timer': function() {
			this.start = new Date().getTime();
		},
		'end': function() {
			console.log("Game over!");
		}
	};
	
	/* Load first question */
	window.game.load_question();
});

window.setInterval(function() {
    if (typeof game == 'undefined') return;
	if (!game.timer_started) return;
    var time = new Date().getTime() - game.start;
    elapsed = Math.floor(time / 100) / 10;

    var clock = Math.round(game.timer - elapsed);
    if (clock <= 0) clock = "Time's up!";
    $('#time').html(clock);
    if (clock === "Time's up!") {
        game.end();
		game.timer_started = false;
    }

}, 100);