<%--
  Created by IntelliJ IDEA.
  User: zhangchao0159
  Date: 2021/6/28
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>协同工作平台</title>
</head>
<script>
    function getProInfo(){
        var w = document.getElementById("t2");
        w.setAttribute("hidden",true);
        //插入行之前先清空行
        var tab=document.getElementById("table");
        rowNum=tab.rows.length;
        for (var j = (rowNum-1); j >= 0; j--){
            tab.deleteRow(j);
        }
        //插入表头
        var tr1=document.createElement("tr");
        var id1=document.createElement("td");
        var proName1=document.createElement("td");
        var creatorName1=document.createElement("td");
        var startTime1=document.createElement("td");
        var endTime1=document.createElement("td");
        var oper1 = document.createElement("td");
        id1.innerHTML="编号";
        proName1.innerHTML="项目号";
        creatorName1.innerHTML="创建者";
        startTime1.innerHTML="开始时间";
        endTime1.innerHTML="截止时间";
        oper1.innerHTML="操作";
        var tab1=document.getElementById("table");
        tab1.appendChild(tr1);
        tr1.appendChild(id1);
        tr1.appendChild(proName1);
        tr1.appendChild(creatorName1);
        tr1.appendChild(startTime1);
        tr1.appendChild(endTime1);
        tr1.appendChild(oper1);


        //然后ajax获取信息
        var xhr1 = new XMLHttpRequest();
        xhr1.open("POST","http://localhost:8081/WebMVC04_war_exploded/ProcessServlet?process=initPro");
        xhr1.send();
        xhr1.onreadystatechange = function(){
            if (xhr1.readyState === 4 && xhr1.status === 200) {
                var s = xhr1.responseText;//返回的字符串，是json格式的字符串
                var x = s.split("],");//分割后每一个元素是一个项目的信息
                // var x1 = x[0].split(/,|:/);//分割每一个项目的具体属性
                for(var i=0;i<x.length-1;i++){//循环遍历每一个项目，在表格中插入后端存储的每一条项目信息
                    //建行和单元格
                    var tr=document.createElement("tr");
                    var id=document.createElement("td");
                    var proName=document.createElement("td");
                    var creatorName=document.createElement("td");
                    var startTime=document.createElement("td");
                    var endTime=document.createElement("td");
                    var oper = document.createElement("td");
                    var check=document.createElement("td");
                    var edit=document.createElement("td");
                    var del=document.createElement("td");
                    var xsingle = x[i].split(/,|:/);//把每个项目拆分成id、项目名称等属性
                    id.innerHTML=xsingle[1];
                    proName.innerHTML=xsingle[3];
                    creatorName.innerHTML=xsingle[5];
                    startTime.innerHTML=xsingle[7];
                    endTime.innerHTML=xsingle[9];
                    check.innerHTML="<input type=\"button\" value=\"查看\" class=\"b2\">";
                    edit.innerHTML="<input type=\"button\" value=\"编辑\" class=\"b2\">";
                    del.innerHTML="<input type=\"button\" value=\"删除\"  onclick=\"deletePro("+xsingle[1]+")\" class=\"b2\">";//出错点，需要传入项目id，写1就行写xsingle[1]就不行
                    var tab=document.getElementById("table");
                    tab.appendChild(tr);
                    tr.appendChild(id);
                    tr.appendChild(proName);
                    tr.appendChild(creatorName);
                    tr.appendChild(startTime);
                    tr.appendChild(endTime);
                    tr.appendChild(oper);
                    oper.appendChild(check);
                    oper.appendChild(edit);
                    oper.appendChild(del);

                }
            }

        }
    }//获取项目信息
    window.onload = function() {//默认页面为项目管理页面
        getProInfo();
    }//默认页面为项目管理
    function deletePro(obj){
        var xhr2 = new XMLHttpRequest();
        // var str1="http://39.107.79.42:8081/javaweb/ProcessServlet?process=deletePro&proID="+obj;
        // alert(str1);
        xhr2.open("POST","http://localhost:8081/WebMVC04_war_exploded/ProcessServlet?process=deletePro&proID="+obj);
        xhr2.send();
        xhr2.onreadystatechange = function(){
            if (xhr2.readyState === 4 && xhr2.status === 200) {
                var result = xhr2.responseText;
                if(result==="Delete Failed!")
                {
                    alert("删除失败!");
                }
                else if(result === "Delete Successful!")
                {
                    alert("删除成功!");
                }
                else if(result === "No Authority!")
                {
                    alert("您无权执行该操作!");
                }
            }
        }
        getProInfo();
    }//删除某项目
    function  getUserInfo() {
        var w = document.getElementById("t2");
        w.setAttribute("hidden",true);
        //插入行之前先清空行,此时需要清除所有行
        var tab = document.getElementById("table");
        //alert(tab.rows.length);
        rowNum = tab.rows.length;
        for (var j = (rowNum - 1); j >= 0; j--) {
            tab.deleteRow(j);
        }
        //然后给新的行头
        var tr1 = document.createElement("tr");
        var id1 = document.createElement("td");
        var userName1 = document.createElement("td");
        var userAuthority1 = document.createElement("td");
        var userEmal1 = document.createElement("td");
        var joinData1 = document.createElement("td");
        var oper1 = document.createElement("td");
        id1.innerText="编号";
        userName1.innerText="姓名";
        userAuthority1.innerText="权限";
        userEmal1.innerText="邮箱";
        joinData1.innerText="加入时间";
        oper1.innerText="操作";

        tab.appendChild(tr1);
        tr1.appendChild(id1);
        tr1.appendChild(userName1);
        tr1.appendChild(userAuthority1);
        tr1.appendChild(userEmal1);
        tr1.appendChild(joinData1);
        tr1.appendChild(oper1);


        var xhr3 = new XMLHttpRequest();
        xhr3.open("POST", "http://localhost:8081/WebMVC04_war_exploded/ProcessServlet?process=initUser");
        xhr3.send();
        xhr3.onreadystatechange = function () {
            if (xhr3.readyState === 4 && xhr3.status === 200) {
                var s = xhr3.responseText;//返回的字符串
                // var x = s.split(/\[|]/);
                var x = s.split("],");//分割后买一个元素是一个项目的信息
                var x1 = x[0].split(/,|:/);//分割每一个项目的具体属性
                //document.getElementById("disPlay").innerHTML = x[2];
                for (var i = 0; i < x.length - 1; i++) {//循环遍历，在表格中插入后端存储的每一条项目信息
                    var tr = document.createElement("tr");
                    var id = document.createElement("td");
                    var userName = document.createElement("td");
                    var userAuthority = document.createElement("td");
                    var userEmal = document.createElement("td");
                    var joinData = document.createElement("td");
                    var oper = document.createElement("td");
                    var check=document.createElement("td");
                    var edit=document.createElement("td");
                    var del=document.createElement("td");
                    var xsingle = x[i].split(/,|:/);

                    id.innerHTML = xsingle[1];
                    userName.innerHTML = xsingle[3];
                    userAuthority.innerHTML = xsingle[5];
                    userEmal.innerHTML = xsingle[7];
                    joinData.innerHTML = xsingle[9];
                    check.innerHTML="<input type=\"button\" value=\"查看\" class=\"b2\">";
                    edit.innerHTML="<input type=\"button\" value=\"编辑\" class=\"b2\">";
                    del.innerHTML="<input type=\"button\" value=\"删除\"  onclick=\"deleteUser("+xsingle[1]+")\" class=\"b2\">";

                    var tab = document.getElementById("table");
                    tab.appendChild(tr);
                    tr.appendChild(id);
                    tr.appendChild(userName);
                    tr.appendChild(userAuthority);
                    tr.appendChild(userEmal);
                    tr.appendChild(joinData);
                    tr.appendChild(oper);
                    oper.appendChild(check);
                    oper.appendChild(edit);
                    oper.appendChild(del);
                }
            }
        }
    }//获取人员信息
    function deleteUser(obj){
        var xhr2 = new XMLHttpRequest();
        xhr2.open("POST","http://localhost:8081/WebMVC04_war_exploded/ProcessServlet?process=deleteUser&userID="+obj);
        xhr2.send();
        xhr2.onreadystatechange = function(){
            if (xhr2.readyState === 4 && xhr2.status === 200) {
                var result = xhr2.responseText;
                if(result==="Delete Failed!")
                {
                    alert("删除失败!");
                }
                else if(result === "Delete Successful!")
                {
                    alert("删除成功!");
                }
                else if(result === "No Authority!")
                {
                    alert("您无权执行该操作!");
                }
            }
        }
        getUserInfo();
    }//删除某人员
    function createPro(){
        var proName = document.getElementById("proName").value;
        var startTime = document.getElementById("startTime").value;
        var endTime = document.getElementById("endTime").value;
        var members = document.getElementById("members").value;
        var xhr=new XMLHttpRequest();
        xhr.open("POST","http://localhost:8081/WebMVC04_war_exploded/ProcessServlet?process=createPro&proName="+proName
            +"&startTime="+startTime+"&endTime="+endTime+"&members="+members);
        xhr.send();
        xhr.onreadystatechange = function()
        {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var result = xhr.responseText;
                alert(result);
            }

        }
        clearText();
        var w = document.getElementById("t2");
        w.setAttribute("hidden",true);

    }
    function displayCP(){
        //删除所有行
        var tab = document.getElementById("table");
        rowNum = tab.rows.length;
        for (var j = (rowNum - 1); j >= 0; j--) {
            tab.deleteRow(j);
        }

        var w = document.getElementById("t2");
        w.removeAttribute("hidden");
    }
    function clearText(){
        var proName = document.getElementById("proName").value="";
        var startTime = document.getElementById("startTime").value="";
        var endTime = document.getElementById("endTime").value="";
        var members = document.getElementById("members").value="";
    }
    function SignOut(){
        var xhr2 = new XMLHttpRequest();
        xhr2.open("POST","http://localhost:8081/WebMVC04_war_exploded/ProcessServlet?process=loginOut");
        xhr2.send();
        window.location = "index.jsp";

    }
</script>
<style type="text/css">
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
    h1{
        text-align: center;
    }
    .buttons1{
        text-align:center;
    }
    .b1{
        display:inline-block;
        margin-right: 200px;
        border-radius: 8px;
        font-size: 20px;
        background-color: #008CBA;
        transition: all 0.5s;
        cursor: pointer;

    }
    .b1 span {
        cursor: pointer;
        display: inline-block;
        position: relative;
        transition: 0.5s;
    }
    .b1 span:after {
        content: '\00bb';
        position: absolute;
        opacity: 0;
        top: 0;
        right: -20px;
        transition: 0.5s;
    }
    .b1:hover span {
        padding-right: 25px;
    }
    .b1:hover span:after {
        opacity: 1;
        right: 0;
    }

    .b2{
        display: inline-block;
        border-radius: 4px;
        background-color: cornflowerblue;
        border: none;
        color: #FFFFFF;
        padding: 20px;
        font-size: 10px;

    }
    .b2:hover {background-color: lightpink}

    .b2:active {
        background-color: lightpink;
        box-shadow: 0 5px #666;
        transform: translateY(4px);
    }
    .b3{
        display: inline-block;
        border-radius: 4px;
        background-color: cornflowerblue;
        border: none;
        color: #FFFFFF;
        padding: 20px;
        font-size: 25px;
        margin-left: 100px;
        margin-right: 200px;
        text-align: center;
    }
    .b3:hover {background-color: lightpink}

    .b3:active {
        background-color: lightpink;
        box-shadow: 0 5px #666;
        transform: translateY(4px);
    }
    .t2:hover {
        opacity: 1.0;
    }
    .t2{
        opacity: 0.5;
        border: 3px solid black;
        position: relative;
        nimation-name: example;
        animation-duration: 6s;
        border-radius: 8px;
    }
    .in{
        width:100%;
        display:inline-block;
        margin-right: 200px;
        border-radius: 8px;
        font-size: 35px;
        padding: 10px;

    }
    .in:hover {background-color: lightblue}

    .in:active {
        background-color: lightblue;
        box-shadow: 0 5px #666;
        transform: translateY(4px);
    }
</style>
<body>
<canvas class="canvas" id="canvas"></canvas>
<h1>协同工作平台</h1>
<div class="buttons1">
<%--    <input type="button" onclick="getProInfo()" value="项目信息" class="b1" style="vertical-align:middle">--%>
    <button type="button" onclick="getProInfo()" class="b1"><span>项目信息</span></button>
    <button type="button" onclick="getUserInfo()" class="b1"><span>用户管理</span></button>
    <button type="button" onclick="displayCP()" class="b1"><span>创建项目</span></button>
    <button type="button" onclick="SignOut()" class="b1"><span>退出登录</span></button>
<%--    <input type="button" value="用户管理" onclick="getUserInfo()" class="b1">--%>
<%--    <input type="button" value="创建项目" onclick="displayCP()" class="b1">--%>
<%--    <input type="button" value="退出登录" class="b1">--%>
    <br>
    <br>
</div>
<div>
    <table class="t1" align="center" id="table" cellspacing="0" border="3px" width="80%">
        <tr>
            <td>编号</td>
            <td>项目名</td>
            <td>创建者</td>
            <td>开始时间</td>
            <td>截止时间</td>
            <td>操作</td>

    </table>
    <br>


    <table class="t2" hidden id="t2" align="center"  cellspacing="0"  width="65%">
        <tr>
            <td height="100px">项目名称：</td>
            <td colspan="3"><input id="proName" class="in" type="text" name="proName"></td>
        </tr>
        <tr>
            <td height="100px">开始时间：</td>
            <td colspan="3"><input id="startTime" class="in" type="date" name="startTime"></td>
        </tr>

        <tr>
            <td height="100px">截止时间：</td>
            <td colspan="3"><input id="endTime" class="in" type="date" name="endTime"></td>
        </tr>

        <tr>
            <td height="100px">参与者:</td>
            <td colspan="3"><input id="members" class="in" type="text" name="members"></td>
        </tr>
        <tr>
            <td height="80px"></td>
            <td><input id="" type="button" value="提交" onclick="createPro()" class="b3">
                <input type="button" value="重置" onclick="clearText()" class="b3"></td>
        </tr>
    </table>
</div>
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

