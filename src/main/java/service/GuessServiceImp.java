package service;

import dao.IUserDao;
import dao.UserDaoImp;
import domain.Task;

import java.sql.SQLException;

/**
 * 普通用户服务类
 */
public class GuessServiceImp implements IUserService{
    private UserDaoImp userDaoImp;
    public GuessServiceImp(IUserDao userDao){
        this.userDaoImp = (UserDaoImp) userDao;
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

    @Override
    public String createPro(String proName, String startTime, String endTime, String members) throws SQLException {
        return "No Authority!";
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
    @Override
    public String deletedPro(String proID) throws SQLException {
        return "No Authority!";
    }

    @Override
    public String deleteUser(String userID) {
        return "No Authority!";
    }

    @Override
    public void addUser(IUserDao IUserDao, Task task) {

    }

    @Override
    public void reduceUser(String userID, String proID) {

    }
}
