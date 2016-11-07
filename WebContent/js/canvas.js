TextCursor = function(fillStyle, width) {
    this.fillStyle = fillStyle || 'rgba(0, 0, 0, 0.7)';
    this.width = width || 2;
    this.left = 0;
    this.top = 0;
};

TextCursor.prototype = {
    getHeight: function(ctx) {
        var h = ctx.measureText('M').width;
        return h + h / 6;
    },

    createPath: function(ctx) {
        ctx.beginPath();
        ctx.rect(this.left, this.top,
            this.width, this.getHeight(ctx));
    },

    draw: function(ctx, left, bottom) {
        ctx.save();

        this.left = left;
        this.top = bottom - this.getHeight(ctx);

        this.createPath(ctx);

        ctx.fillStyle = this.fillStyle;
        ctx.fill();

        ctx.restore();
    },

    erase: function(ctx, imageData) {
        ctx.putImageData(imageData, 0, 0,
            this.left, this.top,
            this.width, this.getHeight(ctx));
    }
};

// Text lines.....................................................

TextLine = function(x, y) { //텍스트 라인을 실행시켜 값을 set시킨다.
    this.text = '';
    this.left = x;
    this.bottom = y;
    this.caret = 0;
};

TextLine.prototype = {
    insert: function(text) {
        this.text = this.text.substr(0, this.caret) + text +
            this.text.substr(this.caret);
        this.caret += text.length;
    },

    removeCharacterBeforeCaret: function() {
        if (this.caret === 0)
            return;

        this.text = this.text.substring(0, this.caret - 1) +
            this.text.substring(this.caret);

        this.caret--;
    },

    getWidth: function(ctx) {
        return ctx.measureText(this.text).width;
    },

    getHeight: function(ctx) {
        var h = ctx.measureText('가').width;
        return h + h / 6;
    },

    draw: function(ctx) {
        ctx.save();
        ctx.textAlign = 'start';
        ctx.textBaseline = 'bottom';

        ctx.strokeText(this.text, this.left, this.bottom);
        ctx.fillText(this.text, this.left, this.bottom);

        ctx.restore();
    },

    erase: function(ctx, imageData) {
        ctx.putImageData(imageData, 0, 0);
    }
};


//canvas 설정
var canvas = document.getElementById('myCanvas');
var ctx = canvas.getContext('2d');

var painting = document.getElementById('myCanvas'); //id가 paint인것을 었는다를 었는다
var paint_style = getComputedStyle(painting); //스타일 값을 얻을수 있는 객체인것 같다


/*var fontSelect = document.getElementById('fontSelect'); //폰트샐랙
var sizeSelect = document.getElementById('sizeSelect'); //글자크기
*/
var fontSelect ; //폰트샐랙
var sizeSelect ; //글자크기
var fillStyleSelect = "black";
var strokeStyleSelect ="black";
var textinput = document.getElementById("textinput");
var GRID_STROKE_STYLE = 'lightgray';
var GRID_HORIZONTAL_SPACING = 10;
var GRID_VERTICAL_SPACING = 10; //새로크기
var clearSize=30;

var cursor = new TextCursor(); //텍스트형태의 커서를 생성한다.
var line;
var blinkingInterval;
var text = null;
var hanglLength = null;
var English = true;
drawingSurfaceImageData = ctx.getImageData(0, 0, canvas.width, canvas.height);



//이미지 설정
canvas.width = parseInt(paint_style.getPropertyValue('width')); //width값을 ㄷ얻는 것같다
canvas.height = parseInt(paint_style.getPropertyValue('height')); //height값을 얻는 객체인듯하다


var imageObj = new Image();
oncheck();//온채크를 한번실행시킨다.


//해당페이지에 필기한것을 새팅시킨다
$(document).ready(function() {
    imageObj.src = document.getElementById('loadImage').value;
    ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
    setInterval("imageSave()",60000);
    
    
})
window.onresize=function(e) {
	imageSave();
	location.reload();
}
window.onunload=function(e) {
	imageSave();
}

function changeCheck(){
	if(document.getElementById('check').checked==true){
		document.getElementById('check').checked=false;
		
		$("#writeForm").html("글쓰기"); 
		$("#HTMLchange").html('<input name="brush" id="linesizeSelect" type="range" style="width:150px" value="2" min="0" max="100" class=" navbar-text" onchange="linesizeSelect1();" /><input type="color" id="lineStyleSelect" value="#FF3636" class="navbar-text" onchange="lineStyleSelect1();"><a onclick="opaqueStyleSelect1();" class="navbar-text">형광</a>'+
				'<a  id="clearAction" value="1" class="navbar-text" onclick="clearAction();">지우기</a><div id="cleargenerate" class="navbar-left"></div>');
		
		
		document.getElementById('writeForm').className='glyphicon glyphicon-font navbar-text';
		oncheck();
	}else{
		document.getElementById('check').checked=true;
		$("#writeForm").html("그리기");  
		$("#HTMLchange").html('<select id="fontSelect" class="navbar-text">'+
						'<option value="Gulim">굴림</option>'+
                  		'<option value="Batang" selected>바탕</option>'+
                  		'<option value="Malgun Gothic">맑은고딕</option>'+
	              	 '</select>'+
	              	  '<select id="sizeSelect" class="navbar-text">'+
							'<option value="5">5 pt</option>'+'<option value="6">6 pt</option>'+'<option value="7">7 pt</option>'+'<option value="8">8 pt</option>'+'<option value="9">9 pt</option>'+'<option value="10">10 pt</option>'+'<option value="11">11 pt</option>'+'<option value="12">12 pt</option>'+
							'<option value="13">13 pt</option>'+'<option value="14">14 pt</option>'+'<option value="15" selected>15 pt</option>'+'<option value="16">16 pt</option>'+'<option value="17">17 pt</option>'+'<option value="18">18 pt</option>'+'<option value="19">19 pt</option>'+'<option value="20">20 pt</option>'+
							'<option value="21">21 pt</option>'+'<option value="22">22 pt</option>'+'<option value="23">23 pt</option>'+'<option value="24">24 pt</option>'+'<option value="25">25 pt</option>'+'<option value="26">26 pt</option>'+'<option value="27">27 pt</option>'+
							'<option value="28">28 pt</option>'+'<option value="29">29 pt</option>'+'<option value="30"> pt</option>'+
						'</select><input type="color" id="fillStyleSelect" onchange="fillStyleSelect1();" value="#000000" class="navbar-text"><input type="color" id="strokeStyleSelect" value="#000000" class="navbar-text" onchange="strokeStyleSelect1();"/>');
		
		fontSelect = document.getElementById('fontSelect'); //폰트샐랙
		sizeSelect = document.getElementById('sizeSelect'); //글자크기
		fillStyleSelect = document.getElementById('fillStyleSelect');
		strokeStyleSelect = document.getElementById('strokeStyleSelect');
		document.getElementById('writeForm').className='glyphicon glyphicon-pencil navbar-text';
		oncheck();
	}
}


function clearCanvas() {   
    ctx.clearRect(0, 0, canvas.width, canvas.height); //시작지점 가로세로 넓이 높이
    ctx.beginPath();
}


//페이지에 저장시킨다.!
function imageSave() {
	blink();
    $.ajax({ //ajax이벤트를 실행 시킨다
        url: '/mooc/user/user_imageSave.mooc',
        type: 'post',
        data: {
            canvas: canvas.toDataURL(),
            pageNum: document.getElementById('pageValue').value,
            type: 'ppt',
            sub_lec_code: document.getElementById('sub_lec_code').value,

        }
    })
}

function pagemove() {
    if (Number(document.getElementById('pageSize').value) < Number(document.getElementById('pageNum').value)) {
        alert("존재하지 않는페이지 입니다");
    } else {
        imageSave();
        location.href = '/mooc/user/user_image.mooc?pageNum=' + document.getElementById('pageNum').value + "&sub_lec_code=" + document.getElementById('sub_lec_code').value;
    }
}

function oncheck() {
	canvas = document.getElementById('myCanvas');
	ctx = canvas.getContext('2d');
	check = document.getElementById('check').checked;
    if (check == true) {
    	ctx.globalAlpha = 1;
    	document.getElementById("clear").checked=false;
		fontSelect.onchange = setFont;
    	sizeSelect.onchange = setFont;
    	
	    cursor.fillStyle = fillStyleSelect.value;
	    cursor.strokeStyle = strokeStyleSelect.value;

	    ctx.fillStyle = fillStyleSelect.value;
	    ctx.strokeStyle = strokeStyleSelect.value;

	    ctx.lineWidth = 2.0;

	    setFont();
	    saveDrawingSurface();
    }else{	   
           var mouse = { x: 0,  y: 0};
           blink();//블링크를 실행시킨다.
           ctx.lineWidth = linesizeSelect.value; //선크기
           ctx.lineJoin = 'round'; //라인이꺽일때 꺽는부분 도형
           ctx.lineCap = 'round'; //포인트의 형태 square는 사각형
           ctx.strokeStyle =  lineStyleSelect.value; //선색
           var clear=document.getElementById("clear").checked
           canvas.addEventListener('mousemove', function(e) { //마우스가 움직이는 좌표의 값을 계속 얻어낸다
        	   	  if(check==false){
        	   		  mouse.x = e.pageX - this.offsetLeft;
        	   		  mouse.y = e.pageY - this.offsetTop;
        	   	  }
           }, false);
	
	       canvas.addEventListener('mousedown', function(e) { //마우스 다운이 일어날때
	    	   if(check==false){
	    		   ctx.beginPath(); //새로운 경로를 그릴것을 선언 시킨다
	    		   ctx.moveTo(mouse.x, mouse.y); //마우스의x값y값 좌표를 얻은후
	    		   canvas.addEventListener('mousemove', onPaint, false); //다운후 마우스가 움직일떄  onPaint로 선을그려나간다
	    	   }
    	   }, false);
	       canvas.addEventListener('mouseup', function() {
	    	   if(check==false){
	    		   canvas.removeEventListener('mousemove', onPaint, false); //선을 그리는것을 멈춘다
	    	   }
           }, false);
	       var onPaint = function() {
	    	   var clear=document.getElementById("clear").checked
	    	   if(clear==false){
	            ctx.lineTo(mouse.x, mouse.y);
	            ctx.stroke(); //선을 적용해라
	    	   }else if(clear==true){
	    			   ctx.clearRect(mouse.x -clearSize/2, mouse.y - clearSize/2, clearSize,clearSize); //시작지점 가로세로 넓이 높이
	    		   ctx.beginPath();
	    	   }
	    }
	       
     }
}
function clearSizeChange() { //값 색상변환되었을때
	clearSize=document.getElementById("clearSize").value;
}

document.getElementById("clear").onchange=function(e){
	blink();
	document.getElementById("check").checked=false;
	oncheck();
}
function clearAction(){
	if(document.getElementById("clear").checked==false){
		$("#cleargenerate").html('<input  id="clearSize"  type="range" style="width:70px" value="15" min="0" max="60" class=" navbar-text" onchange="  clearSizeChange();" />')
		document.getElementById("clear").checked=true;
	}else{
		$("#cleargenerate").html('');
		document.getElementById("clear").checked=false;
	}
}


function blink() {//텍스트라인을 실행시켜 값을 SET 시킨다.
	  blinkingInterval = setTimeout(function(e) {
          cursor.erase(ctx, drawingSurfaceImageData); 
          setTimeout(function(e) {
                 cursor.draw(ctx, -400,-400);
          }, 0);
      }, 0); //1초동안 켜진다



};

lineStyleSelect.onchange = function(e) { //값 색상변환되었을때
	if(document.getElementById('check').checked==false){
		ctx.strokeStyle = lineStyleSelect.value; //커서에 색상을 입힌다
	}
}
function lineStyleSelect1(){
	if(document.getElementById('check').checked==false){
		ctx.strokeStyle = lineStyleSelect.value; //커서에 색상을 입힌다
	}
}

var opaque =false;
function opaqueStyleSelect1(){
	if(document.getElementById('check').checked==false){
		if(opaque==false){
			ctx.globalAlpha = 0.007;
			opaque=true;
		}else{
			ctx.globalAlpha =1;
			opaque=false;
		}
	}
}

linesizeSelect.onchange = function(e) {

	if(document.getElementById('check').checked==false){
		ctx.lineWidth = linesizeSelect.value;
	}
}
function linesizeSelect1(){
	if(document.getElementById('check').checked==false){
		ctx.lineWidth = linesizeSelect.value;
	}
}


function windowToCanvas(x, y) {
    var bbox = canvas.getBoundingClientRect(); //캔버스 글의크기?
    return {
        x: x - bbox.left * (canvas.width / bbox.width), //좌표값을 얻는다
        y: y - bbox.top * (canvas.height / bbox.height) //좌표값을 얻는다
    };
}

function saveDrawingSurface() {
    drawingSurfaceImageData = ctx.getImageData(0, 0, canvas.width, canvas.height); //이미지데이타,
}

function setFont() {
    ctx.font = sizeSelect.value + 'pt ' + fontSelect.value; //사이즈 크기 폰트 종류
}


function blinkCursor(x, y) {
    if (check == true) {
        clearInterval(blinkingInterval); 
        blinkingInterval = setInterval(function(e) {
            cursor.erase(ctx, drawingSurfaceImageData); 
            setTimeout(function(e) {
                if (cursor.left == x && cursor.top + cursor.getHeight(ctx) == y) {
                   cursor.draw(ctx, x, y);
                }
            }, 400);
        }, 1000); //1초동안 켜진다
    }
}

function moveCursor(x, y) { //커서움직임
    if (check == true) {
        cursor.erase(ctx, drawingSurfaceImageData); //텍스트와 서페이스 데이터
        saveDrawingSurface(); //saveDrawingSurface를 실행시켜서 ctx값을 얻늗다.
        ctx.putImageData(drawingSurfaceImageData, 0, 0);
        cursor.draw(ctx, x, y);
        blinkCursor(x, y); //커서의 깜빡거림 메서드로 보낸다
    }
}


//마우스 이벤트
var loc;
var locY;
canvas.onmousedown = function(e) { //캔버스에 마우스다운이 일어났을떼
    if (check == true) {
    	loc = windowToCanvas(e.clientX, e.clientY), //윈도우 캔버스를 실행시켜 loc에 값을 놓는다
            fontHeight = ctx.measureText('W').width; //텍스트의 크기폭을 반환

        fontHeight += fontHeight / 6; //텍스트의 폰트값
        line = new TextLine(loc.x, loc.y); //텍스트라인을 실행시켜 값을 SET 시킨다.
        moveCursor(loc.x, loc.y); //텍스트의커서위치를 옮긴다.
        locY=loc.y;
        hanglLength = 0;
        text = null;
    }
};
///////////////////////////////////////////////////////////////////////////////////////////////////////
fillStyleSelect.onchange = function(e) { //값 색상변환되었을때
	 if (check == true) {
		 alert("1");
		 cursor.fillStyle = fillStyleSelect.value; //커서에 색상을 입힌다
		 ctx.fillStyle = fillStyleSelect.value; //텍스트에 색상을 입힌다,
	 }
}
function fillStyleSelect1() { //값 색상변환되었을때
	alert("2");
	 if (check == true) {
		 alert("1");
		 cursor.fillStyle = fillStyleSelect.value; //커서에 색상을 입힌다
		 ctx.fillStyle = fillStyleSelect.value; //텍스트에 색상을 입힌다,
	 }
}

strokeStyleSelect.onchange = function(e) { //값 (텍스트배경 변환
	if(check == true){
		cursor.strokeStyle = strokeStyleSelect.value;
		ctx.strokeStyle = strokeStyleSelect.value;
	}
    
}
function strokeStyleSelect1(){
	alert("test");
	if(check == true){
		alert("test");
		cursor.strokeStyle = strokeStyleSelect.value;
		ctx.strokeStyle = strokeStyleSelect.value;
	}
}

//키입력

document.onkeydown = function(e) {
    if (e.keyCode == 21 && English == true) {
        English = false;
        hanglLength = 0;
        text = null;
    } else if (e.keyCode == 21 && English == false) {
        English = true;
        hanglLength = 0;
        text = null;
    }
   
    if(e.keyCode==13){
    	var Size=Number(sizeSelect.value)+10;
    	if(locY==loc.y){
    		locY=loc.y+Size;
    	}else{
    		locY+=Size;
    	}
    	line = new TextLine(loc.x, locY); //텍스트라인을 실행시켜 값을 SET 시킨다.
    	line.bottom=locY;
        moveCursor(loc.x, locY);
        ctx.restore();
        hanglLength = 0;
        text = null;

    }

    
    
    if (check == true) {
        if (e.keyCode === 8 || e.keyCode === 13) {
            e.preventDefault();
        }
        if (e.keyCode === 8) {
            ctx.save();
            line.erase(ctx, drawingSurfaceImageData); //문자제거
            line.removeCharacterBeforeCaret(); //전에온문자게거
            moveCursor(line.left + line.getWidth(ctx),
                line.bottom); //커서를 전단계로 움직인다
            line.draw(ctx); //제거된 문자열을 그린다.
            ctx.restore(); 
            text = null;
            hanglLength = null;
        }
    }
}


document.onkeypress = function(e) { //키입력시
    var key = String.fromCharCode(e.which);
    if (check == true) {
        //값을 key코드값으로 바꾼다.
        if (e.which != 32 && English == false) {
            key = englishToKorean(key);
            if (hanglLength == 1) {//
                ctx.save();
                line.erase(ctx, drawingSurfaceImageData); //글자를쓴다
                line.removeCharacterBeforeCaret(); //문자열을 제거한다
                moveCursor(line.left + line.getWidth(ctx),
                    line.bottom); //커서를 움직이다
                line.draw(ctx); //텍스트를입력한다
                ctx.restore(); //컨택스트를 복원시킨다.
            }//1
        }//2
        if (e.which == 32) {//1
            text = null;
            hanglLength = null;
        }//1
        if (e.keyCode !== 8 && !e.ctrlKey && !e.metaKey&&e.keyCode!=13) { //키코드가 8이거나 컨트롤이 아니고 메타키가 아닌경우//1
            e.preventDefault();
            ctx.save();
            line.erase(ctx, drawingSurfaceImageData);
            line.insert(key); //라인에 키 를 인서트 시킨다.
            moveCursor(line.left + line.getWidth(ctx),
                line.bottom); //커서를 움직인다
            line.draw(ctx); 
            ctx.restore();
        }//1
    }//2
}


//한글 만드는 코드!
function englishToKorean(e) //글자를 만든다
{
    if (e <= 9 && e >= 0) {
        hanglLength = 0;
        text = null;
        return e;
    }
    var words = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    if (words.indexOf(e) == -1) {
        hanglLength = 0;
        text = null;
        return e;
    }
    var textLength;
    // 입력한 영문 텍스트 추출
    if (text != "" && text != null) {
        text += e; //키코드값 새팅
        textLength = text.length;
    } else {
        text = e;
        textLength = text.length;
    }
    // 변수 초기화
    var initialCode = 0;
    var medialCode = 0;
    var finalCode = 0;
    var check = 0;
    var array;
    var result = "";
    var overR = ""
        // 입력한 문자열 길이 추출

    if (1 < textLength) {
        for (var idx = 0; idx < textLength; idx++) {

            // 초성 코드 추출
            initialCode = getCode('initial', text.substring(idx, idx + 1));
            idx++; // 다음 문자로.

            tempMedialCode = getCode('medial', text.substring(idx, idx + 2));
            if (tempMedialCode != -1) //2개의 문자에대한 하나의 코드을 출력
            {

                medialCode = tempMedialCode;
                idx += 2;
            } else // 코드값이 없을 경우 하나의 문자에 대한 중성 코드 추출
            {
                medialCode = getCode('medial', text.substring(idx, idx + 1));
                idx++;
            }

            // 현재 문자와 다음 문자를 합한 문자열의 종성 코드 추출
            tempFinalCode = getCode('final', text.substring(idx, idx + 2));

            // 코드 값이 있을 경우
            if (tempFinalCode != -1) {
                // 코드 값을 저장한다.
                finalCode = tempFinalCode;

                // 그 다음의 중성 문자에 대한 코드를 추출한다.
                tempMedialCode = getCode('medial', text.substring(idx + 2, idx + 3));

                // 코드 값이 있을 경우 
                if (tempMedialCode != -1) {
                    // 종성 코드 값을 저장한다.
                    finalCode = getCode('final', text.substring(idx, idx + 1));
                } else {
                    idx++;
                }
            } else // 코드 값이 없을 경우
            {
                // 그 다음의 중성 문자에 대한 코드 추출
                tempMedialCode = getCode('medial', text.substring(idx + 1, idx + 2));

                // 그 다음에 중성 문자가 존재할 경우
                if (tempMedialCode != -1) {
                    // 종성 문자는 없음.
                    finalCode = 0;
                    idx--;
                } else {
                    // 종성 문자 추출
                    finalCode = getCode('final', text.substring(idx, idx + 1));

                    if (finalCode == -1) finalCode = 0;
                }
            }

            // 추출한 초성 문자 코드, 중성 문자 코드, 종성 문자 코드를 합한 후 변환하여 출력
            if (check == 0) {
                result = String.fromCharCode(0xAC00 + initialCode + medialCode + finalCode);
                overR = result;
            } else if (check == 1) {
                result += String.fromCharCode(0xAC00 + initialCode + medialCode + finalCode);
                overR += result;
            }
            hanglLength = 1;

            if (check == 1) {
                hanglLength = 0;
            }
            if (textLength > idx + 1) {
                result = getfirstCode(text.charAt(idx + 1));
                array = text;
                text = text.charAt(idx + 1);
                hanglLength = 0;
                if (textLength > idx + 2) {
                    check = 1;
                    text = array;
                    continue;
                }
                return result;
            }
            if (check == 1) {
                hanglLength = 1;
                result = overR.substring(0, 1) + overR.substring(2, 3);
                var i = text.length;
                text = text.substring(i - 2, i - 1) + text.substring(i - 1, i);
            }
            return result;

        }
    } else if (textLength == 1) {
        var result = getfirstCode(text);
        return result;
    }
}

function getfirstCode(char) {
    var hangl = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ"
    var initial = "rRseEfaqQtTdwWczxvg";
    returnCode = initial.indexOf(char);
    var firstword = hangl.charAt(returnCode);
    return firstword;

}


function getCode(type, char) {
    // 초성
    var initial = "rRseEfaqQtTdwWczxvg";

    // 중성
    var medial = new Array('k', 'o', 'i', 'O', 'j', 'p', 'u', 'P', 'h',
    		'hk', 'ho', 'hl', 'y', 'n', 'nj', 'np', 'nl', 'b', 'm', 'ml', 'l');

    // 종성
    var final = new Array('r', 'R', 'rt', 's', 'sw', 'sg', 'e', 'f', 'fr', 'fa', 'fq',
    		'ft', 'fx', 'fv', 'fg', 'a', 'q', 'qt', 't', 'T', 'd', 'w', 'c', 'z', 'x', 'v', 'g');

    var returnCode; // 리턴 코드 저장 변수

    var isFind = false; // 문자를 찾았는지 체크 변수

    if (type == 'initial') {
        returnCode = initial.indexOf(char) * 21 * 28;
        isFind = true;
    } else if (type == 'medial') {
        for (var i = 0; i < medial.length; i++) {
            if (medial[i] == char) {
                returnCode = i * 28;
                isFind = true;
                break;
            }
        }
    } else if (type == 'final') {
        for (var i = 0; i < final.length; i++) {
            if (final[i] == char) {
                returnCode = i + 1;
                isFind = true;
                break;
            }
        }
    } else {
        alert("잘못된 타입입니다.");
    }

    if (isFind == false) returnCode = -1; // 값을 찾지 못했을 경우 -1 리턴

    return returnCode;
}