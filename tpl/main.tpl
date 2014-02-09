<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Fast Math">

        <title>Fast Math</title>

        <link rel="stylesheet" href="tpl/css/base-min.css">
        <link rel="stylesheet" href="tpl/css/buttons-min.css">
        <link rel="stylesheet" href="tpl/css/grids-min.css">
        <link rel="stylesheet" href="tpl/css/menus-min.css">
        <link rel="stylesheet" href="tpl/css/fmlayout.css">
        <script type="text/javascript" src="js/jquery-2.1.0.min.js"></script>
        <script type="text/javascript" src="js/ui.js"></script>
        <script type="text/javascript" src="js/org/mathdox/formulaeditor/main.js"></script>
        <script type="text/javascript" src="js/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
        {literal}
        <script type='text/javascript'>
                org = { mathdox:{formulaeditor:{options:{dragPalette:true, paletteShow: "none", useBar:true}}}};
        </script>
        {/literal}
    </head>
    <body>
        <div id="content">
            <div class="pure-g-r">
                <div class="pure-u-1-5">
                </div>
                <div class="pure-u-3-5">
                    <img src="tpl/logos/main-logo.png" />
                </div>
                <div class="pure-u-1-5">
                </div>
                <div class="pure-u-1-5">
                </div>
                <div class="pure-u-3-5">
                    <div class="information">
                        <p>
                            Fast Math is a game to help develop mental math skills. It is meant for calculus level math
                            students.  A round of fast math lasts two minutes. The goal of the game 
is to solve as many
                            math problems as possible in the given time.  As the problems are solved a comic strip will
                            be randomly generated for your amusement.
                        </p>
                    </div>
                </div>
                <div class="pure-u-1-5">
                </div>
            </div>
            <div class="play-button">
                <button class="button-xlarge pure-button play" onclick="javascript:play();">Play Now!</button>
            </div>
            <div>

            </div>
        </div>
        
    </body>
    <script type="text/javascript" src="js/comic.js"></script>
</html>
