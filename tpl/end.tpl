	<div class="pure-g-r">
		<div class="pure-u-1-5">
		</div>
		<div class="pure-u-3-5">
			<img src="tpl/logos/end-logo.png" />
		</div>
		<div class="pure-u-1-5">
		</div>
		<div class="pure-u-1-5">
		</div>
		<div class="pure-u-3-5">
			<div id="end-score">
				<p>
					You solved {$score} problems  
				</p>
			</div>
		</div>
		<div class="pure-u-1-5">
		</div>
	</div>
	<div id="comic-wrapper">
		<div id="comic">
			<canvas id="comic-canvas1" width="800" height="400"></canvas>
			<!-- <canvas id="comic-canvas2" width="800" height="400" style="position: absolute; left: 0; top: 0; z-index: 2;></canvas> -->
		</div>
	</div>
	
	<div class="pure-g-r">
		<div class="pure-u-1-5">
		</div>
		<div class="pure-u-3-5">
			<div class="play-button">
                <button class="button-xlarge pure-button play" onclick="javascript:play();">Play Again!</button>
            </div>
		</div>
		<div class="pure-u-1-5">
		</div>
	</div>
	
	<img id="background1" src="tpl/comic-images/background-1.png" width="0px" height="0px"/>
	<img id="background2" src="tpl/comic-images/background-2.png" width="0px" height="0px"/>
	<img id="background3" src="tpl/comic-images/background-3.png" width="0px" height="0px"/>
	<img id="background4" src="tpl/comic-images/background-4.png" width="0px" height="0px"/>
	<img id="background5" src="tpl/comic-images/background-5.png" width="0px" height="0px"/>
	<img id="manLeft1" src="tpl/comic-images/left-man-1.png" width="0px" height="0px"/>
	<img id="manLeft2" src="tpl/comic-images/left-man-2.png" width="0px" height="0px"/>
	<img id="manLeft3" src="tpl/comic-images/left-man-3.png" width="0px" height="0px"/>
	<img id="manLeft4" src="tpl/comic-images/left-man-4.png" width="0px" height="0px"/>
	<img id="manRight1" src="tpl/comic-images/right-man-1.png" width="0px" height="0px"/>
	<img id="manRight2" src="tpl/comic-images/right-man-2.png" width="0px" height="0px"/>
	<img id="manRight3" src="tpl/comic-images/right-man-3.png" width="0px" height="0px"/>
	<img id="manRight4" src="tpl/comic-images/right-man-4.png" width="0px" height="0px"/>
        <script type="text/javascript">
            refreshMath({$comic.seed}, 10);
        </script>