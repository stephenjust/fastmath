/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var loadingHtml = '<div id="loader"><img src="tpl/graphics/ajax-loader.gif" /><br />Loading</div>';

function play() {
    $('#content').html(loadingHtml);
    $.ajax('./problem.php', {
        error: function(jqx, stat, err) {
            $('#content').html('Failwhale');
        },
        success: function(data, status, jqx) {
            $('#content').html(data);
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
            'userinput': org.mathdox.formulaeditor.FormulaEditor.getEditorByTextArea("formula1").getMathML()
        },
        error: function(jqx, stat, err) {
            $('#content').html('Failwhale');
        },
        success: function(data, status, jqx) {
            $('#content').html(data);
        }
    });
}

function refreshMath() {
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]);

    var textarea = document.getElementById("formula1");
    org.mathdox.formulaeditor.FormulaEditor.updateByTextAreas(textarea);
}