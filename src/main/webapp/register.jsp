<%--
  Created by IntelliJ IDEA.
  User: 123
  Date: 2021/6/27
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <script>
        window.load(request());
        function request() {
            var result = "<%=request.getParameter("result")%>";
            if(result==="rigisterFailed")
            {
                alert("注册失败!");
            }
            else if(result === "rigisterSuccess")
            {
                alert("注册成功!");
            }
        }
        //姓名
        function YHMonblus(){
            var userName=document.getElementById("userName");
            var str = /^[a-zA-Z][a-zA-Z]*$/;
            if(userName.value==""){
                document.getElementById('YHMerror').innerText="用户名不能为空";
                document.getElementById('YHMerror').className="";
            }
            else if(!str.test(userName.value)){
                document.getElementById('YHMerror').innerText="格式错误,用户名仅由字母组成";
                document.getElementById('YHMerror').className="";
            }
            else {
                document.getElementById('YHMerror').innerText ="";
                document.getElementById('YHMerror').className="myicon-tick-checked";
            }
        }
        function YHMonfocu(){
            document.getElementById('YHMerror').innerText ="";
            document.getElementById('YHMerror').className="";
        }
        //邮箱
        function DZYXonblus(){
            var email=document.getElementById("email");
            var str =/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            if(email.value==""){
                document.getElementById('DZYXerror').innerText="";
                document.getElementById('DZYXerror').className="";
            }
            else if(!str.test(email.value)){
                document.getElementById('DZYXerror').innerText="邮箱账号格式不正确";
                document.getElementById('DZYXerror').className="";
            }
            else {
                document.getElementById('DZYXerror').innerText ="";
                document.getElementById('DZYXerror').className="myicon-tick-checked";
            }
        }
        function DZYXonfocu(){
            document.getElementById('DZYXerror').innerText =""
            document.getElementById('DZYXerror').className="";
        }
        //账号
        function ZHonblus(){
            var userAccount=document.getElementById("userAccount");
            var str1=RegExp(/</), str2=RegExp(/>/),str3=RegExp(/'/),str4=RegExp(/"/);
            var str = /^[a-zA-Z](?![A-Za-z]+$)[a-zA-Z0-9]{1,}$/;
            if(userAccount.value==""){
                document.getElementById('ZHerror').innerText="账号不能为空";
                document.getElementById('ZHerror').className="";
            }
            else if(userAccount.value.length < 5 ||userAccount.value.length > 15){
                console.log(userAccount.value);
                document.getElementById('ZHerror').innerText="格式错误,长度应为5-15个字符";
                document.getElementById('ZHerror').className="";
            }
            else if(!str.test(userAccount.value)){
                document.getElementById('ZHerror').innerText="账号格式错误，账号由字母和数字组成且以字母开头";
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
                document.getElementById('ZHerror').innerText ="";
                document.getElementById('ZHerror').className="myicon-tick-checked";
            }
        }
        function ZHonfocu(){
            document.getElementById('ZHerror').innerText ="";
            document.getElementById('ZHerror').className="";
        }
        //密码
        function MMonblus(){
            var userPwd=document.getElementById("userPwd");
            var str1=RegExp(/</), str2=RegExp(/>/),str3=RegExp(/'/),str4=RegExp(/"/);
            if(userPwd.value==""){
                document.getElementById('MMerror').innerText="密码不能为空";
                document.getElementById('MMerror').className="";
            }
            else if(str1.test(userPwd.value)){
                document.getElementById('MMerror').innerText="格式错误,密码中不能包含<";
                document.getElementById('MMerror').className="";
            }
            else if(str2.test(userPwd.value)){
                document.getElementById('MMerror').innerText="格式错误,密码中不能包含>";
                document.getElementById('MMerror').className="";
            }
            else if(str3.test(userPwd.value)){
                document.getElementById('MMerror').innerText="格式错误,密码中不能包含'";
                document.getElementById('MMerror').className="";
            }
            else if(str4.test(userPwd.value)){
                document.getElementById('MMerror').innerText="格式错误,密码中不能包含\"";
                document.getElementById('MMerror').className="";
            }
            else {
                document.getElementById('MMerror').innerText ="";
                document.getElementById('MMerror').className="myicon-tick-checked";
            }
        }
        function MMonfocu(){
            document.getElementById('MMerror').innerText ="";
            document.getElementById('MMerror').className="";
        }
        //重复密码
        function REMMonblus(){
            var userPwd=document.getElementById("userPwd");
            var ReuserPwd=document.getElementById("ReuserPwd");
            if(ReuserPwd.value==""){
                document.getElementById('REMMerror').innerText="请再次输入密码";
                document.getElementById('REMMerror').className="";
            }
            else if(!(userPwd.value==ReuserPwd.value)){
                document.getElementById('REMMerror').innerText="两次输入密码不一致";
                document.getElementById('REMMerror').className="";
            }
            else {
                document.getElementById('REMMerror').innerText ="";
                document.getElementById('REMMerror').className="myicon-tick-checked";
            }
        }
        function REMMonfocu(){
            document.getElementById('REMMerror').innerText ="";
            document.getElementById('REMMerror').className="";
        }
        function login(){
            window.location="index.jsp";
        }
    </script>
</head>
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
<body>
<canvas class="canvas" id="canvas"></canvas>


<center>
    <br><br><br>
    <h1>注册界面</h1>
    <form name="register" method="post" action="RegisterServlet"  style="padding: 10px;padding-left: 800px;">
    <fieldset  style="color: black;border-radius: 20px;position:absolute;border: 0;">
            <table  style=" color:black;opacity:0.7;border-radius: 20px;" cellspacing="0" >
                <tr >
                    <td  style="font-size: larger;">姓名</td>
                    <td><input type="text" id="userName" name="userName"  onfocus="YHMonfocu()" onblur="YHMonblus()"  style="width: 250px;height: 40px;font-size: 20px;">
                        <span id="YHMerror">
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
                    <td  style="font-size: larger;">邮箱</td>
                    <td><input type="email" id="email" name="email" class="inputText" onfocus="DZYXonfocu()" onblur="DZYXonblus()" style="width: 250px;height: 40px;font-size: 20px;">
                        <span id="DZYXerror">
                    </span>
                    </td>
                </tr>
                </tr>
                <td>
                    <br>
                </td>
                </tr>
                <tr>
                    <td  style="font-size: larger;">账户</td>
                    <td><input type="text" id="userAccount" name="userAccount" onfocus="ZHonfocu()" onblur="ZHonblus()" style="width: 250px;height: 40px;font-size: 20px;">
                        <span id="ZHerror">
                    </span>
                    </td>
                </tr>
                </tr>
                <td>
                    <br>
                </td>
                </tr>
                <tr>
                    <td  style="font-size: larger;">密码</td>
                    <td><input type="password" id="userPwd" name="userPwd" onfocus="MMonfocu()" onblur="MMonblus()" style="width: 250px;height: 40px;font-size: 20px;">
                        <span id="MMerror">
                </span>
                    </td>
                </tr>
                </tr>
                <td>
                    <br>
                </td>
                </tr>
                <tr>
                    <td  style="font-size: larger;">重复密码</td>
                    <td><input type="password" id="ReuserPwd" name="ReuserPwd" onfocus="REMMonfocu()" onblur="REMMonblus()" style="width: 250px;height: 40px;font-size: 20px;">
                        <span id="REMMerror">
                </span>
                    </td>
                </tr>
                </tr>
                <td>
                    <br>
                </td>
                </tr>
                <tr>
                <tr style="letter-spacing: 10px">
                    <td colspan="2">
                        <input type="submit" value="提  交" onclick="" style="width: 100px;background-color:gray;font-size: larger;">
                        <input type="button" value="重  置" onclick="register.reset()"  style="width: 100px;background-color:gray;font-size: larger;">
                        <input type="button" value="前往登录" onclick="login()" style="width: 100px;background-color:gray;font-size: larger;">
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
