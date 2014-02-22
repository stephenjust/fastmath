/* Start of game set-up */
$(window).load(function() {
	window.game = {
		'seed': $("#game-seed").attr("content"),
		'question': 1,
		'start': new Date().getTime(),
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
			var g = this;
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
					var editor = org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea(textarea);
					editor.focus();
					MathJax.Hub.Typeset(document.getElementById("question"), g.show_math());
				}
			});
		}
	};
	
	/* Load first question */
	window.game.load_question();
});