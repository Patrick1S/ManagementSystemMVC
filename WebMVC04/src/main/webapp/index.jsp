<%--
  Created by IntelliJ IDEA.
  User: 123
  Date: 2021/6/25
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style type="text/css">
        span{color: red}

        /*canvas的大小需要在起标签内设置，否则会拉伸或缩小默认的大小*/
        .canvas{
            border:0;
            /*位置绝对*/
            position: absolute;
            width:100%;
            height: 100%;
            /*设置所在层数，在上层*/
            z-index: -1;
        }

        /**蓝色勾*/
        .myicon-tick-checked {
            display: inline-block;
            position: relative;
            width: 15px;
            height: 15px;
            border-radius: 50%;
            background-color: deepskyblue;
        }



        .myicon-tick-checked:before, .myicon-tick-checked:after{
            content: '';
            pointer-events: none;
            position: absolute;
            color: white;
            border: 1px solid;
            background-color: white;
        }


        .myicon-tick-checked:before {
            width: 1px;
            height: 1px;
            left: 25%;
            top: 50%;
            transform: skew(0deg,50deg);
        }


        .myicon-tick-checked:after {
            width: 3px;
            height: 1px;
            left: 45%;
            top: 42%;
            transform: skew(0deg,-50deg);
        }

    </style>
    <title>登录界面</title>
    <script>
        window.load(request());
        function request() {
            var result = "<%=request.getParameter("result")%>";
            if(result==="loginFalse")
            {
                alert("账户或密码错误!");
            }
        }
        function login(){

        }
        function register(){
            window.location="register.jsp";
        }
        //账号
        function ZHonblus(){
            var userAccount=document.getElementById("userAccount");
            //var re = /^[a-zA-Z_]{6,18}$/;
            var str1=RegExp(/</), str2=RegExp(/>/),str3=RegExp(/'/),str4=RegExp(/"/);
            if(userAccount.value==""){
                document.getElementById('ZHerror').innerText="请输入账号";
            }
            else if(userAccount.value.length < 5 ||userAccount.value.length > 15){
                console.log(userAccount.value);
                document.getElementById('ZHerror').innerText="格式错误,长度应为5-15个字符";
                document.getElementById('ZHerror').className="";
            }
            else if(str1.test(userAccount.value)){
                document.getElementById('ZHerror').innerText="格式错误,账号中不能包含<";
                document.getElementById('ZHerror').className="";
            }
            else if(str2.test(userAccount.value)){
                document.getElementById('ZHerror').innerText="格式错误,账号中不能包含>";
                document.getElementById('ZHerror').className="";
            }
            else if(str3.test(userAccount.value)){
                document.getElementById('ZHerror').innerText="格式错误,账号中不能包含'";
                document.getElementById('ZHerror').className="";
            }
            else if(str4.test(userAccount.value)){
                document.getElementById('ZHerror').innerText="格式错误,账号中不能包含\"";
                document.getElementById('ZHerror').className="";
            }
            else {
                document.getElementById('ZHerror').innerText="";
                document.getElementById('ZHerror').className="myicon-tick-checked";
            }
        }
        function ZHonfocu(){
            document.getElementById('ZHerror').className="";
            document.getElementById('ZHerror').innerText="";
        }
    </script>
</head>
<body>
<canvas class="canvas" id="canvas"></canvas>
        <center >
            <br><br><br><br><br>
            <form name="login" method="post" action="LoginServlet" style="padding: 10px;padding-left: 800px">
                <fieldset style="color: black;border-radius: 20px;position:absolute;">
                        <table  style="color:black;opacity:0.7;border-radius: 20px;border: 10px;" cellspacing="0" >
                            <tr >
                            <td colspan="2" align="center" style="font-size: 35px;">登录界面</td>
                            </tr>
                            <tr >
                            <tr>
                            </tr>
                            <td>
                                <br>
                            </td>
                            </tr>
                                <td  style="font-size: larger;">账号</td>
                                <td><input type="text" id="userAccount" name="userAccount" onfocus="ZHonfocu()" onblur="ZHonblus()"  style="width: 250px;height: 40px;font-size: 20px;">
                                </td>
                                <td>
                                    <span id="ZHerror" class="">
                                    </span>
                                </td>
                            </tr>
                            <tr>
                            </tr>
                            <td>
                                <br>
                            </td>
                            </tr>
                            <tr>
                                <td style="font-size: larger;">密码</td>
                                <td><input type="password" id="userPwd" name="userPwd"  style="width: 250px;height: 40px;font-size: 20px;"></td>
                            </tr>
                            </tr>
                            <td>
                                <br>
                            </td>
                            </tr>
                            <tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" value="登录" onclick="login()" style="width: 100px;background-color:gray;font-size: larger;">
                                    <input type="button" value="注册" onclick="register()" style="width: 100px;background-color:gray;font-size: larger;">
                                </td>
                            </tr>
                          </table>
                </fieldset>
            </form>
        </center>

<script>
    //定义画布宽高和生成点的个数
    var WIDTH = window.innerWidth, HEIGHT = window.innerHeight, POINT = 35;

    var canvas = document.getElementById('canvas');
    canvas.width = WIDTH,
        canvas.height = HEIGHT;
    var context = canvas.getContext('2d');
    context.strokeStyle = 'rgba(0,0,0,0.2)',
        context.strokeWidth = 1,
        context.fillStyle = 'rgba(0,0,0,0.1)';
    var circleArr = [];

    //线条：开始xy坐标，结束xy坐标，线条透明度
    function Line (x, y, _x, _y, o) {
        this.beginX = x,
            this.beginY = y,
            this.closeX = _x,
            this.closeY = _y,
            this.o = o;
    }
    //点：圆心xy坐标，半径，每帧移动xy的距离
    function Circle (x, y, r, moveX, moveY) {
        this.x = x,
            this.y = y,
            this.r = r,
            this.moveX = moveX,
            this.moveY = moveY;
    }
    //生成max和min之间的随机数
    function num (max, _min) {
        var min = arguments[1] || 0;
        return Math.floor(Math.random()*(max-min+1)+min);
    }
    // 绘制原点
    function drawCricle (cxt, x, y, r, moveX, moveY) {
        var circle = new Circle(x, y, r, moveX, moveY)
        cxt.beginPath()
        cxt.arc(circle.x, circle.y, circle.r, 0, 2*Math.PI)
        cxt.closePath()
        cxt.fill();
        return circle;
    }
    //绘制线条
    function drawLine (cxt, x, y, _x, _y, o) {
        var line = new Line(x, y, _x, _y, o)
        cxt.beginPath()
        cxt.strokeStyle = 'rgba(0,0,0,'+ o +')'
        cxt.moveTo(line.beginX, line.beginY)
        cxt.lineTo(line.closeX, line.closeY)
        cxt.closePath()
        cxt.stroke();

    }
    //初始化生成原点
    function init () {
        circleArr = [];
        for (var i = 0; i < POINT; i++) {
            circleArr.push(drawCricle(context, num(WIDTH), num(HEIGHT), num(15, 2), num(10, -10)/40, num(10, -10)/40));
        }
        draw();
    }

    //每帧绘制
    function draw () {
        context.clearRect(0,0,canvas.width, canvas.height);
        for (var i = 0; i < POINT; i++) {
            drawCricle(context, circleArr[i].x, circleArr[i].y, circleArr[i].r);
        }
        for (var i = 0; i < POINT; i++) {
            for (var j = 0; j < POINT; j++) {
                if (i + j < POINT) {
                    var A = Math.abs(circleArr[i+j].x - circleArr[i].x),
                        B = Math.abs(circleArr[i+j].y - circleArr[i].y);
                    var lineLength = Math.sqrt(A*A + B*B);
                    var C = 1/lineLength*7-0.009;
                    var lineOpacity = C > 0.03 ? 0.03 : C;
                    if (lineOpacity > 0) {
                        drawLine(context, circleArr[i].x, circleArr[i].y, circleArr[i+j].x, circleArr[i+j].y, lineOpacity);
                    }
                }
            }
        }
    }

    //调用执行
    window.onload = function () {
        init();
        setInterval(function () {
            for (var i = 0; i < POINT; i++) {
                var cir = circleArr[i];
                cir.x += cir.moveX;
                cir.y += cir.moveY;
                if (cir.x > WIDTH) cir.x = 0;
                else if (cir.x < 0) cir.x = WIDTH;
                if (cir.y > HEIGHT) cir.y = 0;
                else if (cir.y < 0) cir.y = HEIGHT;

            }
            draw();
        }, 16);
    }

</script>
</body>
</html>
