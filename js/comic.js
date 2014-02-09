/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var backgrounds = new Array(
    "http://localhost/fastmath/tpl/comic-images/background-1.png",
    "http://localhost/fastmath/tpl/comic-images/background-1.png"
);
var stringFile = "";
var characters = [
    
];
var decorations = [
    
];

// From http://indiegamr.com/generate-repeatable-random-numbers-in-js/
// in order to work 'Math.seed' must NOT be undefined,
// so in any case, you HAVE to provide a Math.seed
Math.seededRandom = function(max, min) {
    if (max === min) return max;
    
    max = max || 1;
    min = min || 0;
 
    Math.seed = (Math.seed * 9301 + 49297) % 233280;
    var rnd = Math.seed / 233280;
 
    return min + rnd * (max - min);
};


function drawComic(seed, step) {
    Math.seed = seed;
    var stage = new Kinetic.Stage({
        container: 'comic',
        width: 800,
        height: 500
    });
    
    var bgLayer = new Kinetic.Layer();
    var fgLayer = new Kinetic.Layer();
    var textLayer = new Kinetic.Layer();
    
    var bgImage = backgrounds[Math.seededRandom(0, backgrounds.length-1)];
    var imageObj = new Image();
    imageObj.onload = function() {
      var yoda = new Kinetic.Image({
        x: 0,
        y: 0,
        image: imageObj,
        width: 960,
        height: 280
      });

      // add the shape to the layer
      bgLayer.add(yoda);
    };
    imageObj.src = bgImage;

    var rect = new Kinetic.Rect({
        x: 239,
        y: 75,
        width: 100,
        height: 50,
        fill: 'green',
        stroke: 'black',
        strokeWidth: 4
    });

    fgLayer.add(rect);

    // add the layer to the stage
    stage.add(bgLayer);
    stage.add(fgLayer);
    //stage.add(textLayer);
}
