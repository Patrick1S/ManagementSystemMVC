package controller;

import dao.IUserDao;
import dao.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="RegisterServlet", value="/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    /**
     * 用户注册servlet
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获取输入信息，调用dao的add方法往数据库添加数据
        String userName = req.getParameter("userName");
        String email = req.getParameter("email");
        System.out.println("邮箱："+email);
        String userAccount = req.getParameter("userAccount");

        if(userAccount == null || userAccount.equals(""))
        {
            req.getRequestDispatcher("register.jsp?result=rigisterFailed").forward(req,resp);
        }

        String userPwd = req.getParameter("userPwd");
        IUserDao userDao = new UserDaoImp();
        try{
            userDao.add(userName,userAccount,email,userPwd);
            //返回注册成功参数
            req.getRequestDispatcher("register.jsp?result=rigisterSuccess").forward(req,resp);
        }
        catch (Exception e)
        {
            //发生异常
            req.getRequestDispatcher("register.jsp?result=rigisterFailed").forward(req,resp);
        }

    }
}
