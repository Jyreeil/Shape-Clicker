package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class ShapeClicker extends MovieClip {
		
		private var shapeSpeed:Number = .08;
		
		//arrays
		private var circles:Array;
		private var squares:Array;
		private var triangles:Array;
		private var numbers:Array;
		private var shapeBtns:Array;
		private var pentas:Array;
		private var redXes:Array;
		
		//variables
		private var lastNum:Number;
		private var lastColor:String;
		private var lastShape:String;
		private var score:Number = 0;
		private var id:Number = 0;
		private var pentaCount:Number = 0;
		private var cUpVar:Number = 0;
		private var gameMode:String;
		private var multVar:Number = 0;
		private var pentaNum:Number = 8;
		private var redXNum:Number = 8;
		private var maxShapeNum:Number = 10;
		private var maxXNum:Number = 10;
		private var shapeSpawnSpeed:Number = 2000;
		private var amountShapeSpawn:Number = 8;
		private var spawnSpeedCounter:Number = 2000;
		private var amountSpawnCounter:Number = 8;
		private var firstCircle:Boolean = false;
		private var firstSquare:Boolean = false;
		private var firstTriangle:Boolean = false;
		
		
		//tooltip variables
		private var MultToolTip:Number = 1;
		private var SSDToolTip:Number = 1;
		private var LXToolTip:Number = 1;
		private var MPToolTip:Number = 1;
		private var HMSCToolTip:Number = 1;
		private var HMXCToolTip:Number = 1;
		private var FSSToolTip:Number = 1;
		private var MSSToolTip:Number = 1;
		
		//game objects
		private var gameObjects:Sprite;
		
		//used for moving game objects
		private var lastTime:uint;
		
		
		//create timer that splits 8 times in intervals of 2 seconds
		var myTimer1:Timer = new Timer(shapeSpawnSpeed,amountShapeSpawn);
		var myTimer2:Timer = new Timer(shapeSpawnSpeed,amountShapeSpawn);
		var myTimer3:Timer = new Timer(shapeSpawnSpeed,amountShapeSpawn);
		var myTimer4:Timer = new Timer(shapeSpawnSpeed,amountShapeSpawn);
		
		//game mode timers
		var countUpTimer:Timer = new Timer(10,0);
		
		
		//GAME MODES
		
		//endless
		public function startEndless() {
			gameObjects = new Sprite();
			addChild(gameObjects);
			id = 0;
			
			firstCircle = false;
			firstSquare = false;
			firstTriangle = false;
			
			addEventListener(Event.ENTER_FRAME,moveGameObjects);//line 862
			myTimer1.addEventListener(TimerEvent.TIMER, onStart);
			myTimer2.addEventListener(TimerEvent.TIMER, onStart);
			myTimer3.addEventListener(TimerEvent.TIMER, onStart);
			myTimer4.addEventListener(TimerEvent.TIMER, onStart);
			
			circles = new Array();
			squares = new Array();
			triangles = new Array();
			numbers = new Array();
			shapeBtns = new Array();
			pentas = new Array();
			redXes = new Array();
			nextShapeWave();//line 807
			gameMode = "endless";
		}
		
		//countup
		public function startCountUp() {
			gameObjects = new Sprite();
			addChild(gameObjects);
			id = 0;
			
			firstCircle = false;
			firstSquare = false;
			firstTriangle = false;
			
			addEventListener(Event.ENTER_FRAME,moveGameObjects);//line 862
			myTimer1.addEventListener(TimerEvent.TIMER, onStart);
			myTimer2.addEventListener(TimerEvent.TIMER, onStart);
			myTimer3.addEventListener(TimerEvent.TIMER, onStart);
			myTimer4.addEventListener(TimerEvent.TIMER, onStart);
			
			countUpTimer.addEventListener(TimerEvent.TIMER, cUpTime);
			
			circles = new Array();
			squares = new Array();
			triangles = new Array();
			numbers = new Array();
			shapeBtns = new Array();
			pentas = new Array();
			redXes = new Array();
			nextShapeWave();//line 807
			countUpTimer.start();
			gameMode = "countUp";
		}
		
		//CREATE OBJECTS
		
		//circles
		public function newCircle() {
			var directionX:Number;
			var directionY:Number;
			var placementX:Number;
			var placementY:Number;
			var randNum:Number;
			firstCircle = true;
			
			// create
			var newCircle:MovieClip = new MovieClip();
			var newNumber:MovieClip = new MovieClip();
			var newshapeBtn:MovieClip = new MovieClip();
			
			newCircle = new circle();
			newNumber = new Num();
			newshapeBtn = new shapeBtn();
			
			newshapeBtn.buttonMode = true;
			
			randNum = Math.ceil(Math.random()*10);
			newCircle.gotoAndStop(Math.ceil(Math.random()*6));
			newNumber.gotoAndStop("One");
			
			
			// set direction
			directionX = Math.random()*2.0-1.0;
			directionY = Math.random()*2.0-1.0;
			newCircle.dx = directionX
			newCircle.dy = directionY
			newNumber.dx = directionX
			newNumber.dy = directionY
			newshapeBtn.dx = directionX
			newshapeBtn.dy = directionY
			
			// placement											
			placementX = Math.random()*550;		
			placementY = Math.random()*400;
			newCircle.x = placementX
			newCircle.y = placementY
			newNumber.x = placementX
			newNumber.y = placementY
			newshapeBtn.x = placementX
			newshapeBtn.y = placementY
			
			/*for (var k:Number=0;k<circles.length;k++){
				trace (circles[k].id);
			}*/
			
			// ID
			id++;
			newCircle.id = id;
			newNumber.id = id;
			newshapeBtn.id = id;
			
			trace("circles" + id);
			/*for (var j:Number=0;j<circles.length;j++){
				trace (circles[j].id);
			}*/
	
			// add to stage and array
			gameObjects.addChild(newCircle);
			circles.push(newCircle);
			
			gameObjects.addChild(newNumber);
			numbers.push(newNumber);
			
			//newshapeBtn.addEventListener(MouseEvent.CLICK, BtnHit);
			gameObjects.addChild(newshapeBtn);
			shapeBtns.push(newshapeBtn);
			
			
			if (randNum > pentaNum){
				addPenta();
			}
			if (randNum <= redXNum) {
				addRedX();
			}
		}
		
		//squares
		public function newSquare() {
			var directionX:Number;
			var directionY:Number;
			var placementX:Number;
			var placementY:Number;
			var randNum:Number;
			firstSquare = true;
			
			// create
			var newSquare:MovieClip = new MovieClip();
			var newNumber:MovieClip = new MovieClip();
			var newshapeBtn:MovieClip = new MovieClip();
			
			newSquare = new square();
			newNumber = new Num();
			newshapeBtn = new shapeBtn();
			
			newshapeBtn.buttonMode = true;
			
			randNum = Math.ceil(Math.random()*10);
			newSquare.gotoAndStop(Math.ceil(Math.random()*6));
			newNumber.gotoAndStop("One");
			
			// set direction
			directionX = Math.random()*2.0-1.0;
			directionY = Math.random()*2.0-1.0;
			newSquare.dx = directionX
			newSquare.dy = directionY
			newNumber.dx = directionX
			newNumber.dy = directionY
			newshapeBtn.dx = directionX
			newshapeBtn.dy = directionY
			
			// placement											
			placementX = Math.random()*550;		
			placementY = Math.random()*400;
			newSquare.x = placementX
			newSquare.y = placementY
			newNumber.x = placementX
			newNumber.y = placementY
			newshapeBtn.x = placementX
			newshapeBtn.y = placementY
			
			
			// ID
			id++;
			newSquare.id = id;
			newNumber.id = id;
			newshapeBtn.id = id;
			
			trace("squares" + id);
	
			// add to stage and array
			gameObjects.addChild(newSquare);
			squares.push(newSquare);
			
			gameObjects.addChild(newNumber);
			numbers.push(newNumber);
			
			//newshapeBtn.addEventListener(MouseEvent.CLICK, BtnHit);
			gameObjects.addChild(newshapeBtn);
			shapeBtns.push(newshapeBtn);
			
			
			if (randNum > pentaNum){
				addPenta();
			}else if (randNum < redXNum){
				addRedX();
			}
		}
		
		//triangles
		public function newTriangle() {
			var directionX:Number;
			var directionY:Number;
			var placementX:Number;
			var placementY:Number;
			var randNum:Number;
			firstTriangle = true;
			
			// create
			var newTriangle:MovieClip = new MovieClip();
			var newNumber:MovieClip = new MovieClip();
			var newshapeBtn:MovieClip = new MovieClip();
			
			newTriangle = new triangle();
			newNumber = new Num();
			newshapeBtn = new shapeBtn();
			
			newshapeBtn.buttonMode = true;
			
			randNum = Math.ceil(Math.random()*10);
			newTriangle.gotoAndStop(Math.ceil(Math.random()*6));
			newNumber.gotoAndStop("One");
			
			// set direction
			directionX = Math.random()*2.0-1.0;
			directionY = Math.random()*2.0-1.0;
			newTriangle.dx = directionX
			newTriangle.dy = directionY
			newNumber.dx = directionX
			newNumber.dy = directionY
			newshapeBtn.dx = directionX
			newshapeBtn.dy = directionY
			
			// placement											
			placementX = Math.random()*550;		
			placementY = Math.random()*400;
			newTriangle.x = placementX
			newTriangle.y = placementY
			newNumber.x = placementX
			newNumber.y = placementY
			newshapeBtn.x = placementX
			newshapeBtn.y = placementY
			
			
			// ID
			id++;
			newTriangle.id = id;
			newNumber.id = id;
			newshapeBtn.id = id;
			
			trace("triangles" + id);
	
			// add to stage and array
			gameObjects.addChild(newTriangle);
			triangles.push(newTriangle);
			
			gameObjects.addChild(newNumber);
			numbers.push(newNumber);
			
			//newshapeBtn.addEventListener(MouseEvent.CLICK, BtnHit);
			gameObjects.addChild(newshapeBtn);
			shapeBtns.push(newshapeBtn);
			
			
			if (randNum > pentaNum){
				addPenta();
			}else if (randNum < redXNum) {
				addRedX();
			}
		}
		
		//pentas
		public function addPenta(){
			var directionX:Number;
			var directionY:Number;
			var placementX:Number;
			var placementY:Number;
			
			var newPenta:MovieClip = new MovieClip();
			var newshapeBtn:MovieClip = new MovieClip();
			
			newPenta = new penta();
			newshapeBtn = new shapeBtn();
			
			directionX = Math.random()*2.0-1.0;
			directionY = Math.random()*2.0-1.0;
			newPenta.dx = directionX
			newPenta.dy = directionY
			newshapeBtn.dx = directionX
			newshapeBtn.dy = directionY
			
			placementX = Math.random()*550;		
			placementY = Math.random()*400;
			newPenta.x = placementX
			newPenta.y = placementY
			newshapeBtn.x = placementX
			newshapeBtn.y = placementY
			
			id++;
			newPenta.id = id;
			newshapeBtn.id = id;
			
			trace("pentas" + id);
			
			gameObjects.addChild(newPenta);
			pentas.push(newPenta);
			
			//newshapeBtn.addEventListener(MouseEvent.CLICK, BtnHit);
			gameObjects.addChild(newshapeBtn);
			shapeBtns.push(newshapeBtn);
		}
		
		//red xs
		public function addRedX(){
			var directionX:Number;
			var directionY:Number;
			var placementX:Number;
			var placementY:Number;
			
			var newRedX:MovieClip = new MovieClip();
			var newshapeBtn:MovieClip = new MovieClip();
			
			newRedX = new redX();
			newshapeBtn = new shapeBtn();
			
			directionX = Math.random()*2.0-1.0;
			directionY = Math.random()*2.0-1.0;
			newRedX.dx = directionX
			newRedX.dy = directionY
			newshapeBtn.dx = directionX
			newshapeBtn.dy = directionY
			
			placementX = Math.random()*550;		
			placementY = Math.random()*400;
			newRedX.x = placementX
			newRedX.y = placementY
			newshapeBtn.x = placementX
			newshapeBtn.y = placementY
			
			id++;
			newRedX.id = id;
			newshapeBtn.id = id;
			
			trace("redXes" + id);
			
			gameObjects.addChild(newRedX);
			redXes.push(newRedX);
			
			//newshapeBtn.addEventListener(MouseEvent.CLICK, BtnHit);
			gameObjects.addChild(newshapeBtn);
			shapeBtns.push(newshapeBtn);
		}
		
		//MOVE GAME OBJECTS
		
		//circles
		public function moveCircles(timeDiff:uint) {
			
			var newCircle:MovieClip = new MovieClip();
			if(circles != null){
			for(var i:int=circles.length-1;i>=0;i--) {
				// move
				circles[i].x += circles[i].dx*shapeSpeed*timeDiff;
				circles[i].y += circles[i].dy*shapeSpeed*timeDiff;
				newCircle = circles[i];
				
				
				// moved off screen
				if ((circles[i].dx > 0) && (circles[i].x > 560)) {
					circles[i].x -= 570;
				}
				if ((circles[i].dx < 0) && (circles[i].x < -10)) {
					circles[i].x += 570;
				}
				if ((circles[i].dy > 0) && (circles[i].y > 410)) {
					circles[i].y -= 420;
				}
				if ((circles[i].dy < 0) && (circles[i].y < -10)) {
					circles[i].y += 420;
				}
			}
		}
		}
		
		//squares
		public function moveSquares(timeDiff:uint) {
			
			var newSquare:MovieClip = new MovieClip();
			if(squares != null){
				for(var i:int=squares.length-1;i>=0;i--) {
					// move
					squares[i].x += squares[i].dx*shapeSpeed*timeDiff;
					squares[i].y += squares[i].dy*shapeSpeed*timeDiff;
					newSquare = squares[i];
				
				
					// moved off screen
					if ((squares[i].dx > 0) && (squares[i].x > 560)) {
						squares[i].x -= 570;
					}
					if ((squares[i].dx < 0) && (squares[i].x < -10)) {
						squares[i].x += 570;
					}
					if ((squares[i].dy > 0) && (squares[i].y > 410)) {
						squares[i].y -= 420;
					}
					if ((squares[i].dy < 0) && (squares[i].y < -10)) {
						squares[i].y += 420;
					}
				}
			}
		}
		
		//triangles
		public function moveTriangles(timeDiff:uint) {
			
			var newTriangle:MovieClip = new MovieClip();
			if(triangles != null){
			for(var i:int=triangles.length-1;i>=0;i--) {
				// move
				triangles[i].x += triangles[i].dx*shapeSpeed*timeDiff;
				triangles[i].y += triangles[i].dy*shapeSpeed*timeDiff;
				newTriangle = triangles[i];
				
				
				// moved off screen
				if ((triangles[i].dx > 0) && (triangles[i].x > 560)) {
					triangles[i].x -= 570;
				}
				if ((triangles[i].dx < 0) && (triangles[i].x < -10)) {
					triangles[i].x += 570;
				}
				if ((triangles[i].dy > 0) && (triangles[i].y > 410)) {
					triangles[i].y -= 420;
				}
				if ((triangles[i].dy < 0) && (triangles[i].y < -10)) {
					triangles[i].y += 420;
				}
			}
		}
		}
		
		//numbers
		public function moveNums(timeDiff:uint) {
			
			var newNumber:MovieClip = new MovieClip();
			if(numbers != null){
			for(var i:int=numbers.length-1;i>=0;i--) {
				// move
				numbers[i].x += numbers[i].dx*shapeSpeed*timeDiff;
				numbers[i].y += numbers[i].dy*shapeSpeed*timeDiff;
				newNumber = numbers[i];
				
				
				// moved off screen
				if ((numbers[i].dx > 0) && (numbers[i].x > 560)) {
					numbers[i].x -= 570;
				}
				if ((numbers[i].dx < 0) && (numbers[i].x < -10)) {
					numbers[i].x += 570;
				}
				if ((numbers[i].dy > 0) && (numbers[i].y > 410)) {
					numbers[i].y -= 420;
				}
				if ((numbers[i].dy < 0) && (numbers[i].y < -10)) {
					numbers[i].y += 420;
				}
			}
		}
		}
		
		//buttons
		public function moveBtns(timeDiff:uint) {
			
			var newshapeBtn:MovieClip = new MovieClip();
			if(shapeBtns != null){
			for(var i:int=shapeBtns.length-1;i>=0;i--) {
				// move
				shapeBtns[i].x += shapeBtns[i].dx*shapeSpeed*timeDiff;
				shapeBtns[i].y += shapeBtns[i].dy*shapeSpeed*timeDiff;
				newshapeBtn = shapeBtns[i];
				
				
				// moved off screen
				if ((shapeBtns[i].dx > 0) && (shapeBtns[i].x > 560)) {
					shapeBtns[i].x -= 570;
				}
				if ((shapeBtns[i].dx < 0) && (shapeBtns[i].x < -10)) {
					shapeBtns[i].x += 570;
				}
				if ((shapeBtns[i].dy > 0) && (shapeBtns[i].y > 410)) {
					shapeBtns[i].y -= 420;
				}
				if ((shapeBtns[i].dy < 0) && (shapeBtns[i].y < -10)) {
					shapeBtns[i].y += 420;
				}
				newshapeBtn.addEventListener(MouseEvent.CLICK, BtnHit);
			}
		}
		}
		
		//pentas
		public function movePentas(timeDiff:uint) {
			
			var newPenta:MovieClip = new MovieClip();
			if(pentas != null){
			for(var i:int=pentas.length-1;i>=0;i--) {
				// move
				pentas[i].x += pentas[i].dx*shapeSpeed*timeDiff;
				pentas[i].y += pentas[i].dy*shapeSpeed*timeDiff;
				newPenta = pentas[i];
				
				
				// moved off screen
				if ((pentas[i].dx > 0) && (pentas[i].x > 560)) {
					pentas[i].x -= 570;
				}
				if ((pentas[i].dx < 0) && (pentas[i].x < -10)) {
					pentas[i].x += 570;
				}
				if ((pentas[i].dy > 0) && (pentas[i].y > 410)) {
					pentas[i].y -= 420;
				}
				if ((pentas[i].dy < 0) && (pentas[i].y < -10)) {
					pentas[i].y += 420;
				}
			}
		}
		}
		
		//red xs
		public function moveRedXes(timeDiff:uint) {
			
			var newRedX:MovieClip = new MovieClip();
			if(redXes != null){
			for(var i:int=redXes.length-1;i>=0;i--) {
				// move
				redXes[i].x += redXes[i].dx*shapeSpeed*timeDiff;
				redXes[i].y += redXes[i].dy*shapeSpeed*timeDiff;
				newRedX = redXes[i];
				
				
				// moved off screen
				if ((redXes[i].dx > 0) && (redXes[i].x > 560)) {
					redXes[i].x -= 570;
				}
				if ((redXes[i].dx < 0) && (redXes[i].x < -10)) {
					redXes[i].x += 570;
				}
				if ((redXes[i].dy > 0) && (redXes[i].y > 410)) {
					redXes[i].y -= 420;
				}
				if ((redXes[i].dy < 0) && (redXes[i].y < -10)) {
					redXes[i].y += 420;
				}
			}
		}
		}
		
		//OBJECT HITS
		
		//buttons
		public function BtnHit(event:MouseEvent):void{
			
			var curFrame:Number;
			var pos:Number;
			var shapePos:Number;
			var btnPos:Number;
			var XPos:Number;
			var pntaPos:Number;
			
			var clickedBtn:MovieClip = event.currentTarget as MovieClip;
			
			trace(clickedBtn);
			trace("CB ID = " + clickedBtn.id);
			//find the id of the number that was on the shape so it can be destroyed later
			if(numbers != null){
				for (var i:Number=0;i<numbers.length;i++){
					if (numbers[i].id == clickedBtn.id){
						pos = i;
					}
				}
			}
			
			//find the id of the button so that it can be destroyed later
			for (var q:Number=0;q<shapeBtns.length;q++){
				if (shapeBtns[q].id == clickedBtn.id){
					btnPos = q;
				}
			}
			
			trace("button position = " + btnPos);
			
			/*if(redXes != null){
				for (var a:Number=0;a<redXes.length;a++){
					if (redXes[a].id == clickedBtn.id){
						XPos = a;
					}
				}
			}
			
			if(pentas != null){
				for (var b:Number=0;b<pentas.length;b++){
					if (pentas[b].id == clickedBtn.id){
						pntaPos = b;
					}
				}
			}*/
			
			/*for (var p:Number=0;p<triangles.length;p++){
				trace (triangles[p].id);
			}*/
			
			//destroy the clicked on triangle and update all other numbers and the score if the color or shape is the same as the last
			var newTriangle:MovieClip = new MovieClip();
			var newNumber:MovieClip = new MovieClip();
			var newBtn:MovieClip = new MovieClip();
			if(triangles != null){
				for (var j:Number=0;j<triangles.length;j++){
					if (triangles[j].id == clickedBtn.id){
						newTriangle = triangles[j];
						newNumber = numbers[pos];
						if (lastShape == "Triangle" || lastColor == newTriangle.currentFrameLabel){
							for(var m:int=numbers.length-1;m>=0;m--) {
								if (numbers[m].currentFrame != 9){
									curFrame = numbers[m].currentFrame;
									numbers[m].gotoAndStop(curFrame+1);
								}
							}
							addScore(1);
						}
						newBtn = shapeBtns[btnPos];
						shapePos = j;
						lastShape = "Triangle";
						lastColor = newTriangle.currentFrameLabel;
						gameObjects.removeChild(newTriangle);
						triangles.splice(shapePos,1);
						newTriangle = null;
						//remove the number on the clicked shape
						gameObjects.removeChild(newNumber);
						numbers.splice(pos,1);
						newNumber = null;
						//remove the shape button on the clicked shape
						gameObjects.removeChild(newBtn);
						shapeBtns.splice(btnPos,1);
						newBtn = null;
					}
				}
			}
			
			//destroy the clicked on circle and update all other numbers and the score if the color or shape is the same as the last
			var newCircle:MovieClip = new MovieClip();
			if (clickedBtn != null){
				if(circles != null){
					for (var k:Number=0;k<circles.length;k++){
						if (circles[k].id == clickedBtn.id){
							newCircle = circles[k];
							newNumber = numbers[pos];
							if (lastShape == "Circle" || lastColor == newCircle.currentFrameLabel){
								for(var n:int=numbers.length-1;n>=0;n--) {
									if (numbers[n].currentFrame != 9){
										curFrame = numbers[n].currentFrame;
										numbers[n].gotoAndStop(curFrame+1);
									}
								}
								addScore(1);
							}
							newBtn = shapeBtns[btnPos];
							shapePos = k;
							lastShape = "Circle";
							lastColor = newCircle.currentFrameLabel;
							gameObjects.removeChild(newCircle);
							circles.splice(shapePos,1);
							newCircle = null;
							//remove the number on the clicked shape
							gameObjects.removeChild(newNumber);
							numbers.splice(pos,1);
							newNumber = null;
							//remove the shape button on the clicked shape
							gameObjects.removeChild(newBtn);
							shapeBtns.splice(btnPos,1);
							newBtn = null;
						}
					}
				}
			}
			
			//destroy the clicked on square and update all other numbers and the score if the color or shape is the same as the last
			var newSquare:MovieClip = new MovieClip();
			if (clickedBtn != null){
				if(squares != null){
					for (var l:Number=0;l<squares.length;l++){
						if (squares[l].id == clickedBtn.id){
							newSquare = squares[l];
							newNumber = numbers[pos];
							if (lastShape == "Square" || lastColor == newSquare.currentFrameLabel){
								for(var o:int=numbers.length-1;o>=0;o--) {
									if (numbers[o].currentFrame != 9){
										curFrame = numbers[o].currentFrame;
										numbers[o].gotoAndStop(curFrame+1);
									}
								}
								addScore(1);
							}
							newBtn = shapeBtns[btnPos];
							shapePos = l;
							lastShape = "Square";
							lastColor = newSquare.currentFrameLabel;
							gameObjects.removeChild(newSquare);
							squares.splice(shapePos,1);
							newSquare = null;
							//remove the number on the clicked shape
							gameObjects.removeChild(newNumber);
							numbers.splice(pos,1);
							newNumber = null;
							//remove the shape button on the clicked shape
							gameObjects.removeChild(newBtn);
							shapeBtns.splice(btnPos,1);
							newBtn = null;
						}
					}
				}
			}
			
			var newPenta:MovieClip = new MovieClip();
			if (clickedBtn != null){
				if(pentas != null){
					for (var s:Number=0;s<pentas.length;s++){
						if (pentas[s].id == clickedBtn.id){
							pentaCount++;
							newBtn = shapeBtns[btnPos];
							newPenta = pentas[s];
							shapePos = s;
							gameObjects.removeChild(newPenta);
							pentas.splice(shapePos,1);
							newPenta = null;
							//remove the shape button on the clicked shape
							gameObjects.removeChild(newBtn);
							shapeBtns.splice(btnPos,1);
							newBtn = null;
						}
					}
				}
			}
			
			var newRedX:MovieClip = new MovieClip();
			if (clickedBtn != null){
				if(redXes != null){
					for (var p:Number=0;p<redXes.length;p++){
						if (redXes[p].id == clickedBtn.id){
							newBtn = shapeBtns[btnPos];
							newRedX = redXes[p];
							shapePos = p;
							gameObjects.removeChild(newRedX);
							redXes.splice(shapePos,1);
							newRedX = null;
							//remove the shape button on the clicked shape
							gameObjects.removeChild(newBtn);
							shapeBtns.splice(btnPos,1);
							newBtn = null;
						}
					}
				}
			}
			
			
			//increase the score for every shape with a 9
			for(var r:int=numbers.length-1;r>=0;r--) {
				if (numbers[r].currentFrame == 9){
					addScore(1);
				}
			}
			
			
			if (circles.length > maxShapeNum || squares.length > maxShapeNum || triangles.length > maxShapeNum){
				endLevel();
			}else if ((circles.length < 1 && firstCircle == true) || (squares.length < 1  && firstSquare == true) || (triangles.length < 1 && firstTriangle == true)){
				nextShapeWave();//line 515
			}
			if (redXes.length > maxXNum) {
				endGame();
			}
		}
		
		
		//UPGRADES
		
		
		
		var multBtn:MovieClip = new MovieClip();
		var shapeSpDown:MovieClip = new MovieClip();
		var lessX:MovieClip = new MovieClip();
		var morePenta:MovieClip = new MovieClip();
		var higherMaxShapes :MovieClip = new MovieClip();
		var higherMaxX:MovieClip = new MovieClip();
		var fasterShapeSpawn:MovieClip = new MovieClip();
		var moreShapeSpawn:MovieClip = new MovieClip();
		var backBtn1:MovieClip = new MovieClip();
		var pentasText:TextField = new TextField();
		var pentaNumText:TextField = new TextField();
		var PMCounter:TextField = new TextField();
		var SSDCounter:TextField = new TextField();
		var LXCounter:TextField = new TextField();
		var MPCounter:TextField = new TextField();
		var HMSCCounter:TextField = new TextField();
		var HMXCCounter:TextField = new TextField();
		var FSSCounter:TextField = new TextField();
		var MSSCounter:TextField = new TextField();
		var textFormat:TextFormat = new TextFormat("Font1", 36, 0x00FF00);
		var embeddedFont:Font = new Font1();
		
		
		public function addObjects(){
			textFormat.font = embeddedFont.fontName;
			textFormat.size = 36;
			textFormat.align = "right";
			
			
			gameObjects = new Sprite();
			addChild(gameObjects);
			multBtn = new multiplier();
			multBtn.gotoAndStop("regular");
			multBtn.x = 138;
			multBtn.y = 33.85;

			multBtn.buttonMode = true

			gameObjects.addChild(multBtn);

			multBtn.addEventListener(MouseEvent.CLICK,callMult);

			multBtn.addEventListener(MouseEvent.ROLL_OVER, multOver);

			multBtn.addEventListener(MouseEvent.MOUSE_OUT, multOut);
			
			shapeSpDown = new speedDown();
			shapeSpDown.gotoAndStop("regular");
			shapeSpDown.x = 164;
			shapeSpDown.y = 77.75;

			shapeSpDown.buttonMode = true

			gameObjects.addChild(shapeSpDown);
			shapeSpDown.addEventListener(MouseEvent.CLICK,callShapeSpDown);
			shapeSpDown.addEventListener(MouseEvent.ROLL_OVER,speedOver);
			shapeSpDown.addEventListener(MouseEvent.MOUSE_OUT, speedDownOut);
			
			
			lessX = new lessXs();
			lessX.gotoAndStop("regular");
			lessX.x = 83.50;
			lessX.y = 121.65;
			
			lessX.buttonMode = true
			gameObjects.addChild(lessX);
			lessX.addEventListener(MouseEvent.CLICK,callLessX);
			lessX.addEventListener(MouseEvent.ROLL_OVER,lessXOver);
			lessX.addEventListener(MouseEvent.MOUSE_OUT, lessXOut);
			
			morePenta = new morePentas();
			morePenta.gotoAndStop("regular");
			morePenta.x = 114.50;
			morePenta.y = 165.55;
			
			morePenta.buttonMode = true

			gameObjects.addChild(morePenta);
			morePenta.addEventListener(MouseEvent.CLICK,callMorePenta);
			morePenta.addEventListener(MouseEvent.ROLL_OVER,morePentaOver);
			morePenta.addEventListener(MouseEvent.MOUSE_OUT, morePentaOut);
			
			higherMaxShapes = new moreShapes();
			higherMaxShapes.gotoAndStop("regular");
			higherMaxShapes.x = 190.50;
			higherMaxShapes.y = 209.45;
			
			higherMaxShapes.buttonMode = true
			gameObjects.addChild(higherMaxShapes);
			higherMaxShapes.addEventListener(MouseEvent.CLICK,callhigherMaxShapes);
			higherMaxShapes.addEventListener(MouseEvent.ROLL_OVER,higherMaxShapesOver);
			higherMaxShapes.addEventListener(MouseEvent.MOUSE_OUT, higherMaxShapesOut);
			
			
			higherMaxX = new moreMaxXs();
			higherMaxX.gotoAndStop("regular");
			higherMaxX.x = 159.00;
			higherMaxX.y = 253.35;
			
			higherMaxX.buttonMode = true
			gameObjects.addChild(higherMaxX);
			higherMaxX.addEventListener(MouseEvent.CLICK,callhigherMaxX);
			higherMaxX.addEventListener(MouseEvent.ROLL_OVER,higherMaxXOver);
			higherMaxX.addEventListener(MouseEvent.MOUSE_OUT, higherMaxXOut);
			
			
			fasterShapeSpawn = new fasterSpawn();
			fasterShapeSpawn.gotoAndStop("regular");
			fasterShapeSpawn.x = 168.50;
			fasterShapeSpawn.y = 297.25;
			
			fasterShapeSpawn.buttonMode = true
			gameObjects.addChild(fasterShapeSpawn);
			fasterShapeSpawn.addEventListener(MouseEvent.CLICK,callfasterShapeSpawn);
			fasterShapeSpawn.addEventListener(MouseEvent.ROLL_OVER,fasterShapeSpawnOver);
			fasterShapeSpawn.addEventListener(MouseEvent.MOUSE_OUT, fasterShapeSpawnOut);
			
			
			moreShapeSpawn = new moreSpawn();
			moreShapeSpawn.gotoAndStop("regular");
			moreShapeSpawn.x = 161.00;
			moreShapeSpawn.y = 341.15;
			
			fasterShapeSpawn.buttonMode = true
			gameObjects.addChild(moreShapeSpawn);
			moreShapeSpawn.addEventListener(MouseEvent.CLICK,callmoreShapeSpawn);
			moreShapeSpawn.addEventListener(MouseEvent.ROLL_OVER,moreShapeSpawnOver);
			moreShapeSpawn.addEventListener(MouseEvent.MOUSE_OUT, moreShapeSpawnOut);
			
			backBtn1 = new backBtn();
			backBtn1.x = 502.50
			backBtn1.y = 33.85
			
			gameObjects.addChild(backBtn1);
			backBtn1.addEventListener(MouseEvent.CLICK,goBack);
			
			pentasText.x = 442.00
			pentasText.y = 56.00
			pentasText.width = 100.00
			pentasText.height = 43.90
			pentasText.embedFonts = true;
			pentasText.defaultTextFormat = textFormat;
			pentasText.text = "Pentas"
			gameObjects.addChild(pentasText);
			
			
			pentaNumText.x = 495.00
			pentaNumText.y = 99.90
			pentaNumText.width = 22.00
			pentaNumText.height = 43.90
			pentaNumText.embedFonts = true;
			pentaNumText.defaultTextFormat = textFormat;
			pentaNumText.text = "0"
			pentaNumText.type = TextFieldType.DYNAMIC;
			gameObjects.addChild(pentaNumText);
			
			
			PMCounter.x = 405.00
			PMCounter.y = 11.90
			PMCounter.width = 22.00
			PMCounter.height = 43.90
			PMCounter.embedFonts = true;
			PMCounter.defaultTextFormat = textFormat;
			PMCounter.text = "0"
			PMCounter.type = TextFieldType.DYNAMIC;
			
			SSDCounter.x = 337.00
			SSDCounter.y = 55.80
			SSDCounter.width = 90.00
			SSDCounter.height = 43.90
			SSDCounter.embedFonts = true;
			SSDCounter.defaultTextFormat = textFormat;
			SSDCounter.text = "0.08"
			SSDCounter.type = TextFieldType.DYNAMIC;
			
			LXCounter.x = 405.00
			LXCounter.y = 99.70
			LXCounter.width = 22.20
			LXCounter.height = 43.90
			LXCounter.embedFonts = true;
			LXCounter.defaultTextFormat = textFormat;
			LXCounter.text = "0"
			LXCounter.type = TextFieldType.DYNAMIC;
			
			MPCounter.x = 405.00
			MPCounter.y = 143.60
			MPCounter.width = 22.00
			MPCounter.height = 43.90
			MPCounter.embedFonts = true;
			MPCounter.defaultTextFormat = textFormat;
			MPCounter.text = "0"
			MPCounter.type = TextFieldType.DYNAMIC;
			
			HMSCCounter.x = 385.00
			HMSCCounter.y = 187.50
			HMSCCounter.width = 45.00
			HMSCCounter.height = 43.90
			HMSCCounter.embedFonts = true;
			HMSCCounter.defaultTextFormat = textFormat;
			HMSCCounter.text = "10"
			HMSCCounter.type = TextFieldType.DYNAMIC;
			
			HMXCCounter.x = 385.00
			HMXCCounter.y = 231.40
			HMXCCounter.width = 45.00
			HMXCCounter.height = 43.90
			HMXCCounter.embedFonts = true;
			HMXCCounter.defaultTextFormat = textFormat;
			HMXCCounter.text = "10"
			HMXCCounter.type = TextFieldType.DYNAMIC;
			
			FSSCounter.x = 350.00
			FSSCounter.y = 275.30
			FSSCounter.width = 80.00
			FSSCounter.height = 43.90
			FSSCounter.embedFonts = true;
			FSSCounter.defaultTextFormat = textFormat;
			FSSCounter.text = "2000"
			FSSCounter.type = TextFieldType.DYNAMIC;
			
			MSSCounter.x = 385.00
			MSSCounter.y = 319.20
			MSSCounter.width = 45.00
			MSSCounter.height = 43.90
			MSSCounter.embedFonts = true;
			MSSCounter.defaultTextFormat = textFormat;
			MSSCounter.text = "8"
			MSSCounter.type = TextFieldType.DYNAMIC;
			
			gameObjects.addChild(PMCounter);
			gameObjects.addChild(SSDCounter);
			gameObjects.addChild(LXCounter);
			gameObjects.addChild(MPCounter);
			gameObjects.addChild(HMSCCounter);
			gameObjects.addChild(HMXCCounter);
			gameObjects.addChild(FSSCounter);
			gameObjects.addChild(MSSCounter);
		}
		
		function goBack(event:MouseEvent) {
				removeObjects();
			if (gameMode == "endless"){
				gotoAndStop("Endless");
			}else if (gameMode == "countUp"){
				gotoAndStop("cUp");
			}
		}
		
		
		public function removeObjects(){
			gameObjects.removeChild(multBtn);
			gameObjects.removeChild(shapeSpDown);
			gameObjects.removeChild(lessX);
			gameObjects.removeChild(morePenta);
			gameObjects.removeChild(higherMaxShapes);
			gameObjects.removeChild(higherMaxX);
			gameObjects.removeChild(fasterShapeSpawn);
			gameObjects.removeChild(moreShapeSpawn);
			gameObjects.removeChild(PMCounter);
			gameObjects.removeChild(SSDCounter);
			gameObjects.removeChild(LXCounter);
			gameObjects.removeChild(MPCounter);
			gameObjects.removeChild(HMSCCounter);
			gameObjects.removeChild(HMXCCounter);
			gameObjects.removeChild(FSSCounter);
			gameObjects.removeChild(MSSCounter);	
			gameObjects.removeChild(backBtn1);
			gameObjects.removeChild(pentasText);
			gameObjects.removeChild(pentaNumText);
			resetVars();
			multBtn.removeEventListener(MouseEvent.CLICK,callMult);
			multBtn.removeEventListener(MouseEvent.ROLL_OVER, multOver);
			multBtn.removeEventListener(MouseEvent.MOUSE_OUT, multOut);
			shapeSpDown.removeEventListener(MouseEvent.CLICK,callShapeSpDown);
			shapeSpDown.removeEventListener(MouseEvent.ROLL_OVER,speedOver);
			shapeSpDown.removeEventListener(MouseEvent.MOUSE_OUT, speedDownOut);
			lessX.removeEventListener(MouseEvent.CLICK,callLessX);
			lessX.removeEventListener(MouseEvent.ROLL_OVER,lessXOver);
			lessX.removeEventListener(MouseEvent.MOUSE_OUT, lessXOut);
			morePenta.removeEventListener(MouseEvent.CLICK,callMorePenta);
			morePenta.removeEventListener(MouseEvent.ROLL_OVER,morePentaOver);
			morePenta.removeEventListener(MouseEvent.MOUSE_OUT, morePentaOut);
			higherMaxShapes.removeEventListener(MouseEvent.CLICK,callhigherMaxShapes);
			higherMaxShapes.removeEventListener(MouseEvent.ROLL_OVER,higherMaxShapesOver);
			higherMaxShapes.removeEventListener(MouseEvent.MOUSE_OUT, higherMaxShapesOut);
			higherMaxX.removeEventListener(MouseEvent.CLICK,callhigherMaxX);
			higherMaxX.removeEventListener(MouseEvent.ROLL_OVER,higherMaxXOver);
			higherMaxX.removeEventListener(MouseEvent.MOUSE_OUT, higherMaxXOut);
			fasterShapeSpawn.removeEventListener(MouseEvent.CLICK,callfasterShapeSpawn);
			fasterShapeSpawn.removeEventListener(MouseEvent.ROLL_OVER,fasterShapeSpawnOver);
			fasterShapeSpawn.removeEventListener(MouseEvent.MOUSE_OUT, fasterShapeSpawnOut);
			moreShapeSpawn.removeEventListener(MouseEvent.CLICK,callmoreShapeSpawn);
			moreShapeSpawn.removeEventListener(MouseEvent.ROLL_OVER,moreShapeSpawnOver);
			moreShapeSpawn.removeEventListener(MouseEvent.MOUSE_OUT, moreShapeSpawnOut);
			backBtn1.removeEventListener(MouseEvent.CLICK,goBack);
		}
		
		function callMult(event:MouseEvent) {
			addMult();
		}
		
		function multOver(event:MouseEvent) {
			multBtn.gotoAndStop("over");
			showMult();
			gameObjects.setChildIndex(multBtn, gameObjects.numChildren - 1);
		}
		
		function multOut(event:MouseEvent) {
			multBtn.gotoAndStop("regular");
			//setChildIndex(multBtn, numChildren + 1);
		}
		
		function callShapeSpDown(event:MouseEvent) {
			if (shapeSpeed > 0.02){
				lowerShapeSpeed();
			}
		}

		function speedOver(event:MouseEvent) {
			shapeSpDown.gotoAndStop("over");
			showSpeedDown();
			gameObjects.setChildIndex(shapeSpDown, gameObjects.numChildren - 1);
		}

		function speedDownOut(event:MouseEvent) {
			shapeSpDown.gotoAndStop("regular");
			//setChildIndex(shapeSpDown, numChildren + 1);
		}
		
		function callLessX(event:MouseEvent) {
			if(redXNum > 0){
				decreaseRedXNum();
			}
		}


		function lessXOver(event:MouseEvent) {
			lessX.gotoAndStop("over");
			showLessXs();
			gameObjects.setChildIndex(lessX, gameObjects.numChildren - 1);
		}


		function lessXOut(event:MouseEvent) {
			lessX.gotoAndStop("regular");
			//setChildIndex(lessX, numChildren + 1);
		}


		
		function callMorePenta(event:MouseEvent) {
			if(pentaNum > 0){
				decreasePentaNum();
			}
			
		}
		
		
		function morePentaOver(event:MouseEvent) {
			morePenta.gotoAndStop("over");
			showMorePenta();
			gameObjects.setChildIndex(morePenta, gameObjects.numChildren - 1);
		}
		
		
		function morePentaOut(event:MouseEvent) {
			morePenta.gotoAndStop("regular");
			//setChildIndex(morePenta, numChildren + 1);
		}


		
		function callhigherMaxShapes(event:MouseEvent) {
			if(maxShapeNum < 25){
				increaseMaxShapes();
			}
		}
		
		
		function higherMaxShapesOver(event:MouseEvent) {
			higherMaxShapes.gotoAndStop("over");
			showhigherMaxShapes();
			gameObjects.setChildIndex(higherMaxShapes, gameObjects.numChildren - 1);
		}
		
		
		function higherMaxShapesOut(event:MouseEvent) {
			higherMaxShapes.gotoAndStop("regular");
			//setChildIndex(morePenta, numChildren + 1);
		}


		
		function callhigherMaxX(event:MouseEvent) {
			if(maxXNum < 30){
				increasemaxXs();
			}
		}
		
		
		function higherMaxXOver(event:MouseEvent) {
			higherMaxX.gotoAndStop("over");
			showhigherMaxX();
			gameObjects.setChildIndex(higherMaxX, gameObjects.numChildren - 1);
		}
		
		
		function higherMaxXOut(event:MouseEvent) {
			higherMaxX.gotoAndStop("regular");
			//setChildIndex(morePenta, numChildren + 1);
		}


		
		function callfasterShapeSpawn(event:MouseEvent) {
			if(myTimer1.delay > 200){
				increaseShapeSpawnSpeed();
			}
		}
		
		
		function fasterShapeSpawnOver(event:MouseEvent) {
			fasterShapeSpawn.gotoAndStop("over");
			showfasterShapeSpawn();
			gameObjects.setChildIndex(fasterShapeSpawn, gameObjects.numChildren - 1);
		}
		
		
		function fasterShapeSpawnOut(event:MouseEvent) {
			fasterShapeSpawn.gotoAndStop("regular");
			//setChildIndex(fasterShapeSpawn, numChildren + 1);
		}
		
		function callmoreShapeSpawn(event:MouseEvent) {
			if(myTimer1.repeatCount < 20){
				increaseShapeSpawnAmount();
			}
		}
		
		
		function moreShapeSpawnOver(event:MouseEvent) {
			moreShapeSpawn.gotoAndStop("over");
			showmoreShapeSpawn();
			gameObjects.setChildIndex(moreShapeSpawn, gameObjects.numChildren - 1);
		}
		
		
		function moreShapeSpawnOut(event:MouseEvent) {
			moreShapeSpawn.gotoAndStop("regular");
			//setChildIndex(fasterShapeSpawn, numChildren + 1);
		}
		
		
		public function addMult(){
			multVar++;
			MultToolTip++;
			this.multBtn.ToolTipMult.embedFonts = false;

			this.multBtn.ToolTipMult.text = "Cost: " + MultToolTip + "  Multiplies points scored by the number bought";
			PMCounter.text = multVar.toString();
		}
		
		public function showMult(){
			this.multBtn.ToolTipMult.embedFonts = false;

			this.multBtn.ToolTipMult.text = "Cost: " + MultToolTip + "  Multiplies points scored by the number bought";
		}
		
		public function lowerShapeSpeed(){
			var shapeSpeedString:String = "";
			if (shapeSpeed > 0.02){
				shapeSpeed -= .01;
			}
			shapeSpeedString = shapeSpeed.toFixed(2);
			SSDCounter.text = shapeSpeedString;
			SSDToolTip++;
			this.shapeSpDown.ToolTipSSD.embedFonts = false;
			this.shapeSpDown.ToolTipSSD.text = "Cost: " + SSDToolTip + "  Lowers the speed of shapes";
		}
		
		public function showSpeedDown(){
			this.shapeSpDown.ToolTipSSD.embedFonts = false;
			this.shapeSpDown.ToolTipSSD.text = "Cost: " + SSDToolTip + "  Lowers the speed of shapes";
		}
		
		public function decreaseRedXNum(){
			redXNum--;
			LXToolTip++;
			this.lessX.ToolTipLX.embedFonts = false;
			this.lessX.ToolTipLX.text = "Cost: " + LXToolTip + "  Lowers the amount of X's that spawn";
			LXCounter.text = redXNum.toString();
		}
		
		public function showLessXs(){
			this.lessX.ToolTipLX.embedFonts = false;
			this.lessX.ToolTipLX.text = "Cost: " + LXToolTip + "  Lowers the amount of X's that spawn";
		}
		
		public function decreasePentaNum(){
			pentaNum--;
			MPToolTip++;
			this.morePenta.ToolTipMP.embedFonts = false;
			this.morePenta.ToolTipMP.text = "Cost: " + MPToolTip + "  Raises the amount of pentas that spawn";
			MPCounter.text = pentaNum.toString();
		}
		
		public function showMorePenta(){
			this.morePenta.ToolTipMP.embedFonts = false;
			this.morePenta.ToolTipMP.text = "Cost: " + MPToolTip + "  Raises the amount of pentas that spawn";
		}
		
		public function increaseMaxShapes(){
			maxShapeNum++;
			HMSCToolTip++;
			this.higherMaxShapes.ToolTipHMSC.embedFonts = false;
			this.higherMaxShapes.ToolTipHMSC.text = "Cost: " + HMSCToolTip + "  Increases the amount of shapes within each type before end of round";
			HMSCCounter.text = maxShapeNum.toString();
		}
		
		public function showhigherMaxShapes(){
			this.higherMaxShapes.ToolTipHMSC.embedFonts = false;
			this.higherMaxShapes.ToolTipHMSC.text = "Cost: " + HMSCToolTip + "  Increases the amount of shapes within each type before end of round";
		}
		
		public function increasemaxXs(){
			maxXNum++;
			HMXCToolTip++;
			this.higherMaxX.ToolTipHMXC.embedFonts = false;
			this.higherMaxX.ToolTipHMXC.text = "Cost: " + HMXCToolTip + "  Increases the amount of X'es before the game is over";
			HMXCCounter.text = maxXNum.toString();
		}
		
		public function showhigherMaxX(){
			this.higherMaxX.ToolTipHMXC.embedFonts = false;
			this.higherMaxX.ToolTipHMXC.text = "Cost: " + HMXCToolTip + "  Increases the amount of X'es before the game is over";
		}
		
		public function increaseShapeSpawnSpeed(){
			myTimer1.delay -= 100;
			myTimer2.delay -= 100;
			myTimer3.delay -= 100;
			myTimer4.delay -= 100;
			spawnSpeedCounter -= 100;
			FSSToolTip++;
			this.fasterShapeSpawn.ToolTipFSS.embedFonts = false;
			this.fasterShapeSpawn.ToolTipFSS.text = "Cost: " + FSSToolTip + "  Makes shapes appear faster.";
			FSSCounter.text = spawnSpeedCounter.toString();
		}
		
		public function showfasterShapeSpawn(){
			this.fasterShapeSpawn.ToolTipFSS.embedFonts = false;
			this.fasterShapeSpawn.ToolTipFSS.text = "Cost: " + FSSToolTip + "  Makes shapes appear faster.";
		}
		
		public function increaseShapeSpawnAmount(){
			myTimer1.repeatCount += 1;
			myTimer2.repeatCount += 1;
			myTimer3.repeatCount += 1;
			myTimer4.repeatCount += 1;
			amountSpawnCounter++;
			MSSToolTip++;
			this.moreShapeSpawn.ToolTipMSS.embedFonts = false;
			this.moreShapeSpawn.ToolTipMSS.text = "Cost: " + MSSToolTip + "  Will cause more shapes to spawn every time they start spawning.";
			MSSCounter.text = amountSpawnCounter.toString();
		}
		
		public function showmoreShapeSpawn(){
			this.moreShapeSpawn.ToolTipMSS.embedFonts = false;
			this.moreShapeSpawn.ToolTipMSS.text = "Cost: " + MSSToolTip + "  Will cause more shapes to spawn every time they start spawning.";
		}
		
		//UPDATES AND CREATION TIMERS
		
		//adds the argument to the score and updates the score text
		public function addScore(mod:int){
			if(multVar > 0){
				score += mod * multVar;
				scoreText.text = score.toString();
			}else{
				score += mod;
				scoreText.text = score.toString();
			}
		}
		
		public function subtractScore(mod:int){
			score -= mod;
			scoreText.text = score.toString();
		}
		
		//starts the next shape wave using whichever timer has not been started yet
		public function nextShapeWave(){
			if (myTimer1.currentCount != 0){
				if (myTimer2.currentCount != 0){
					if (myTimer3.currentCount != 0){
						myTimer4.start();
					}else{
						myTimer3.start();
					}
				}else {
					myTimer2.start();
				}
			}else {
				myTimer1.start();
			}
			timerReset();
			//trace(myTimer1.currentCount);
		}
		
		//resets timers
		public function timerReset(){
			if (myTimer1.currentCount == 8){
				myTimer1.reset();
			}
			if (myTimer2.currentCount == 8){
				myTimer2.reset();
			}
			if (myTimer3.currentCount == 8){
				myTimer3.reset();
			}
			if (myTimer4.currentCount == 8){
				myTimer4.reset();
			}
		}
		
		//calls the shape creation functions triggered by the mytimers 1-4
		public function onStart(e:TimerEvent):void{
			//choose a random shape
			var choice:Number = Math.floor(Math.random()*3)+1;
			if (choice == 1){
				newCircle();
			}else if (choice == 2){
				newSquare();
			}else{
				newTriangle();
			}
		}
		
		//updated the count up time text in count up mode
		public function cUpTime(e:TimerEvent):void{
			cUpVar += .01;
			
			countUpTime.text = cUpVar.toFixed(2);
		}
		
		//moves game objects
		public function moveGameObjects(event:Event) {
			// get timer difference and animate
			var timePassed:uint = getTimer() - lastTime;
			lastTime += timePassed;
			moveCircles(timePassed);
			moveSquares(timePassed);
			moveTriangles(timePassed);
			moveNums(timePassed);
			moveBtns(timePassed);
			movePentas(timePassed);
			moveRedXes(timePassed);
		}
		
		//remove the shapes
		
		public function removeShapeBtns() {
			//var newshapeBtn:MovieClip = shapeBtns[shapeBtns.length - 1];
			if (shapeBtns != null){
				gameObjects.removeChild(shapeBtns.pop());
			}
			//newshapeBtn.removeEventListener(MouseEvent.CLICK, BtnHit);
		}
		
		public function removeCircles() {
			gameObjects.removeChild(circles.pop());
		}
		
		public function removeSquares() {
			gameObjects.removeChild(squares.pop());
		}
		
		public function removeTriangles() {
			gameObjects.removeChild(triangles.pop());
		}
		
		public function removeNumbers() {
			gameObjects.removeChild(numbers.pop());
		}
		
		public function removePentas() {
			gameObjects.removeChild(pentas.pop());
		}
		
		public function removeRedXes() {
			gameObjects.removeChild(redXes.pop());
		}
		
		//remove all the shapes
		public function removeAllShapes() {
			while (shapeBtns.length > 0) {
				removeShapeBtns();
			}
			while (circles.length > 0) {
				removeCircles();
			}
			while (squares.length > 0) {
				removeSquares();
			}
			while (triangles.length > 0) {
				removeTriangles();
			}
			while (numbers.length > 0) {
				removeNumbers();
			}
			while (pentas.length > 0) {
				removePentas();
			}
			while (redXes.length > 0) {
				removeRedXes();
			}
		}
		
		//triggered by the mouseclick on the endgame button
		public function endGameMouse(event:MouseEvent):void {
			endGame();
		}
		
		
		public function resetVars(){
			id = 0;
			
			firstCircle = false;
			firstSquare = false;
			firstTriangle = false;
		}
		

		
		
		public function endLevel(){
			stage.removeEventListener(Event.ENTER_FRAME,moveGameObjects);
			stage.removeEventListener(Event.ENTER_FRAME,nextShapeWave);
			endBtn1.removeEventListener(MouseEvent.CLICK, endGame);
			stage.removeEventListener(TimerEvent.TIMER, onStart);
			myTimer1.stop();
			myTimer2.stop();
			myTimer3.stop();
			myTimer4.stop();
			removeAllShapes();
			gotoAndStop("upgrades");
			pentaNumText.text = pentaCount.toString();
		}
		
		//ends the game
		public function endGame() {
			stage.removeEventListener(Event.ENTER_FRAME,moveGameObjects);
			stage.removeEventListener(Event.ENTER_FRAME,nextShapeWave);
			endBtn1.removeEventListener(MouseEvent.CLICK, endGame);
			stage.removeEventListener(TimerEvent.TIMER, onStart);
			myTimer1.stop();
			myTimer2.stop();
			myTimer3.stop();
			myTimer4.stop();
			removeAllShapes();
			gotoAndStop("endGame");
			if (gameMode == "endless"){
				endScoreText.text = score.toString();
			}else if (gameMode == "countUp"){
				countUpTimer.removeEventListener(TimerEvent.TIMER, cUpTime);
				countUpTimer.stop();
				endScoreText.text = score.toString();
				time.text = cUpVar.toFixed(2);
			}
		}
	}
}