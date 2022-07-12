package service;

import dao.IUserDao;
import dao.UserDaoImp;
import domain.Task;

import java.sql.SQLException;

/**
 * 管理员服务类
 */
public class AdminServiceImp implements IUserService{
    private UserDaoImp userDaoImp;
    public AdminServiceImp(IUserDao userDao){
        this.userDaoImp = (UserDaoImp) userDao;
    }

    @Override
    public String createPro(String proName, String startTime, String endTime, String members)  {
            return userDaoImp.createPro(proName, startTime, endTime, members);
    }

    @Override
    public void joinPro(Task task) throws SQLException {

    }

    @Override
    public void quitPro(Task task) throws SQLException {

    }

    @Override
    public void changePwd(String pwd) {

    }

    /**
     * 退出登录
     */
    @Override
    public void loginOut() {
        userDaoImp.loginOut();
    }

    /**
     * 管理员操作
     * @param proID
     */
    public String deletedPro(String proID) {
        try {
            userDaoImp.deletedPro(proID);
            return "Delete Successful!";
        }catch (Exception e)
        {
            e.printStackTrace();
            return "Delete Failed!";
        }
    }

    /**
     * 删除用户
     */
    public String deleteUser(String userID)  {
        try {
            userDaoImp.deleteUser(userID);
            return "Delete Successful!";
        }catch (Exception e)
        {
            return "Delete Failed!";
        }
    }

    /**
     * 为任务增加人数
     */
    public void addUser(IUserDao IUserDao, Task task)
    {

    }

    /**
     * 为任务削减人数
     */
    public void reduceUser(String userID, String proID)
    {

    }

    @Override
    public String selectUser() throws SQLException {
        return userDaoImp.selectUser();
    }

    /**
     * 页面初始化时获取项目信息
     * @throws SQLException
     */
    @Override
    public String selectPro() throws SQLException {
        return userDaoImp.selectPro();
    }
}
