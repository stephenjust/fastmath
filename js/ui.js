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