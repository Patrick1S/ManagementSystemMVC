package dao;

import domain.Task;
import domain.User;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;

public interface IUserDao {
    /**\
     * 管理员和用户的通用属性和操作
     */
    public User login(String account, String pwd);
    public void add(String userName, String account, String email, String pwd) throws SQLException;
    public String createPro(String proName, String startTime, String endTime, String members) throws SQLException, ParseException;
    public void joinPro(String userID, String proID,String joinDate, String proName, String userName) throws SQLException;
    public void quitPro(Task task) throws SQLException;
    public void changePwd(String pwd);
    public void loginOut();
    public String selectPro() throws SQLException;
    public String selectUser() throws SQLException;
}
