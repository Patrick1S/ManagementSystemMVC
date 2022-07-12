package controller;
import service.IUserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="ProcessServlet", value = "/ProcessServlet")
public class ProcessServlet extends HttpServlet{
    private IUserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        this.userService = (IUserService) req.getSession().getAttribute("userService");

        String process = req.getParameter("process");
        System.out.println(process);
        //获取参数指令，调用对应操作
        switch(process) {
//            修改密码
            case "changePwd":userService.changePwd("");break;

            //删除项目
            case "deletePro":
                String proID = req.getParameter("proID");
                System.out.println("proID:"+proID);
                try {
                    //处理请求返回处理结果
                    String re = userService.deletedPro(proID);
                    resp.getWriter().print(re);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                    resp.getWriter().print("Delete Failed!");
                }
                break;

//          删除用户信息
            case "deleteUser":
                String userID = req.getParameter("userID");
                try{
                    //处理请求返回处理结果
                    String re = userService.deleteUser(userID);
                    System.out.println(re);
                    resp.getWriter().print(re);
                }catch (Exception e)
                {
                    e.printStackTrace();
                    resp.getWriter().print("Delete Failed!");
                }
                break;

            //页面初始化,加载项目信息
            case "initPro":
                try {
                    //处理请求返回处理结果
                    String re = userService.selectPro();
                    resp.getWriter().print(re);
                    System.out.println(re);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                    resp.getWriter().print("Initial Failed!");
                }
                break;

//                页面初始化，加载用户信息
            case "initUser":
                try{
                    //处理请求返回处理结果
                    String re = userService.selectUser();
                    resp.getWriter().print(re);
                }catch (Exception e)
                {
                    resp.getWriter().print("Initial Failed!");
                }
                break;

//                创建项目
            case "createPro":
                try{
                    //处理请求返回处理结果
                    String proName = req.getParameter("proName");
                    if(proName == null || proName.equals("")){
                        resp.getWriter().print("Create Failed!");
                        break;
                    }
                    String startTime = req.getParameter("startTime");
                    String endTime = req.getParameter("endTime");
                    String members = req.getParameter("members");
                    String re = userService.createPro(proName,startTime,endTime,members);
                    resp.getWriter().print(re);
                }catch (Exception e)
                {
                    e.printStackTrace();
                    resp.getWriter().print("Create Failed!");
                }
                break;

//                退出登录
            case "loginOut":
                try {
                    userService.loginOut();
                    userService = null;
                    req.getSession().invalidate();
                    resp.sendRedirect("index.jsp");
                }catch (Exception e){}
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
