<div class="pure-g-r">
        <div class="pure-u-1-5">
        </div>
        <div class="pure-u-1-5">
                <img src="tpl/logos/main-logo-small.png" />
        </div>
        <div class="pure-u-2-5">
                <img src="tpl/logos/arrows-{$math.solved}.png" />
        </div>
        <div class="pure-u-1-1">
        </div>
</div>
<div id="game-wrapper">
        <div class="pure-g-r">
                <div class="pure-u-2-3">
                        <div id="math-wrapper">
                                <div id="question">
                                        <p>
                                                $${$math.question}$$
                                        </p>
                                </div>
                                <script type="text/javascript">
                                    refreshMath({$comic.seed}, {$comic.step});
                                </script>
                                <div class="pure-g-r">
                                        <div class="pure-u-2-3">
                                                <div id="answer">
                                                        <textarea id="formula1" class="mathdoxformula">{$response}</textarea>
                                                </div>
                                        </div>
                                        <div class="pure-u-1-3">
                                                <div id="incorrect-answer">
                                                    {if $error}
														<img src="tpl/logos/incorrect.png" />
													{/if}
                                                </div>
                                        </div>
                                </div>
                        </div>
                </div>
                <div class="pure-u-1-3">
                        <div id="time-container">
							<p>
								Time Remaining <br/>
							</p>
							<p id="time">
								
							</p>
                        </div>
                        <div class="submit-button">
                                <button id="problem-submit" class="button-xlarge pure-button submit" onclick="javascript:problemSubmit({$math.seed}, '{$math.type}');">Submit</button>
                        </div>
                </div>
        </div>
</div>
	<div id="comic-wrapper">
		<div id="comic">
			<canvas id="comic-canvas1" width="800" height="400"></canvas>
			<!-- <canvas id="comic-canvas2" width="800" height="400" style="position: absolute; left: 0; top: 0; z-index: 2;></canvas> -->
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