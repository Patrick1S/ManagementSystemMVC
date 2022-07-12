package service;

import dao.IUserDao;
import domain.Task;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;

public interface IUserService {
    public String createPro(String proName, String startTime, String endTime, String members) throws SQLException, ParseException;
    public void joinPro(Task task) throws SQLException;
    public void quitPro(Task task) throws SQLException;
    public void changePwd(String pwd);
    public void loginOut();
    public String deletedPro(String proID) throws SQLException;
    public String deleteUser(String userID) throws SQLException;
    public void addUser(IUserDao IUserDao, Task task);
    public void reduceUser(String userID, String proID);
    public String selectPro() throws SQLException;
    public String selectUser() throws SQLException;
}
