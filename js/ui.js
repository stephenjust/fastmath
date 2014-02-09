/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var loadingHtml = '<div id="loader"><img src="tpl/logos/octocat.jpeg width="100px" /><br /><img src="tpl/graphics/ajax-loader.gif" width="100px" /><br />Loading</div>';

function play() {
    $('#content').html(loadingHtml);
    $.ajax('./problem.php', {
        error: function(jqx, stat, err) {
            $('#content').html('Failwhale');
        },
        success: function(data, status, jqx) {
            $('#content').html(data);
            startTimer();
        }
    });
}

function problemSubmit(seed, type) {
    $('#content').html(loadingHtml);
    $.ajax({
        type: 'POST',
        url: './problem.php?randomseed=' + encodeURI(seed)
            + '&amp;type=' + encodeURI(type),
        data: {
            'userinput': org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea("formula1").getMathML(),
            'fieldval': org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea("formula1").value
        },
        error: function(jqx, stat, err) {
            $('#content').html('Failwhale');
        },
        success: function(data, status, jqx) {
            $('#content').html(data);
        }
    });
}

function refreshMath(comic_seed, comic_step) {
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]);

    var textarea = document.getElementById("formula1");
    org.mathdox.formulaeditor.FormulaEditor.updateByTextAreas(textarea);
    drawComic(comic_seed, comic_step);
}


var started = 0;
var start = 0;
var elapsed = '0.0';

function startTimer() {
    start = new Date().getTime(),
    elapsed = '0.0';
    started = 1;
}

window.setInterval(function()
{
    if (!started) return;
    var time = new Date().getTime() - start;

    elapsed = Math.floor(time / 100) / 10;

    var clock = Math.round(120 - elapsed);
    if (clock <= 0) clock = "Time's up!";
    $('#time').html(clock);
    if (clock === "Time's up!") {
            started=0;
            $.ajax({
            url: './end.php',
            error: function(jqx, stat, err) {
                $('#content').html('Failwhale');
            },
            success: function(data, status, jqx) {
                $('#content').html(data);
            }
        });
    }

}, 100);