package controller;

import dao.IUserDao;
import dao.UserDaoImp;
import domain.User;
import service.AdminServiceImp;
import service.IUserService;
import service.GuessServiceImp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name="LoginServlet", value="/LoginServlet")
public class LoginServlet extends HttpServlet{

    /**
     * 验证用户登录，注册
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
        System.out.println("servlet");
        String userAccount = req.getParameter("userAccount");
        String userPwd = req.getParameter("userPwd");
        IUserDao userDao = new UserDaoImp();
        //查询用户记录
        User user = userDao.login(userAccount, userPwd);

        if (user == null)
        {
            //user为空，表示账户或密码错误
            System.out.println("？？？？");
            req.getRequestDispatcher("./index.jsp?result=loginFalse").forward(req, resp);
        }
        else
        {
            //登陆成功，开启服务
            IUserService userService;
            if(user.getAuthority().equals("admin")){
                //启动管理员服务
                userService = new AdminServiceImp(userDao);
            }
            else{
                //启动普通用户服务
                userService = new GuessServiceImp(userDao);
            }
            HttpSession session = req.getSession();
            //将当前userDao设置为session属性
            session.setAttribute("userService", userService);
            System.out.println("进入management");
            req.getRequestDispatcher("./WEB-INF/pages/management.jsp").forward(req, resp);
        }
    }


}
