package dao;

import domain.Task;
import domain.User;
import util.Conn;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.*;
import java.text.SimpleDateFormat;

public class UserDaoImp implements IUserDao {
    private Connection con;
    private Statement sql;
    private ResultSet rs;
    public User currentUser;

    /**
     * 登录
     * @param account
     * @param pwd
     */
    @Override
    public User login(String account, String pwd) {
        try{
            User user = null;
            Conn conn = new Conn();
            con = conn.getCon();
            // 计算md5函数
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(pwd.getBytes());
            pwd = String.valueOf(new BigInteger(1, md.digest()).toString(16));

            //预编译，防止SQL注入
            PreparedStatement pstmt = con.prepareStatement("select * from users where (userAccount=? and userPwd=?)");
            pstmt.setString(1,account);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();


            if (rs.next()) {
                System.out.println("AAA");
                user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setName(rs.getString("userName"));
                user.setAuthority(rs.getString("userAuthority"));
                user.setEmail(rs.getString("userEmail"));
                user.setJoinDate(rs.getDate("joinDate"));
                user.setAccount(account);
                this.currentUser = user;
                return user;
            }
            this.currentUser = null;
        }catch (Exception e) {
            System.out.println("账号或密码错误!");
            throw new RuntimeException(e);
        }
        return null;
    }

    /**
     * 页面初始化
     * 加载用户信息
     * @return
     * @throws SQLException
     */
    @Override
    public String selectUser() throws SQLException {
        PreparedStatement pstmt = con.prepareStatement("select * from users");
        rs = pstmt.executeQuery();
        String users = "";
        //拼接用户信息字符串
        while (rs.next()) {
            users += "[";
            String id = String.valueOf(rs.getInt("userID"));
            String userName = rs.getString("userName");
            String userAuthority = rs.getString("userAuthority");
            String userEmail = rs.getString("userEmail");
            String joinDate = rs.getString("joinDate");
            users += "id:"+id+","+"userName:"+userName+","+"userAuthority:"+userAuthority+","+"userEmail:"+userEmail+","+"joinDate:"+joinDate+"],";
        }
        System.out.println(users);
        return users;
    }

    /**
     * 页面初始化
     * 查询项目概要信息
     * @return
     */
    @Override
    public String selectPro() throws SQLException {
        PreparedStatement pstmt = con.prepareStatement("select * from projects");
        rs = pstmt.executeQuery();
        String projects = "";
        //拼接项目信息字符串
        while (rs.next()) {
            projects += "[";
            String id = String.valueOf(rs.getInt("proID"));
            String proName = rs.getString("proName");
            String creatorName = rs.getString("creatorName");
            String startTime = rs.getString("startTime");
            String endTime = rs.getString("endTime");
            projects += "id:"+id+","+"proName:"+proName+","+"creatorName:"+creatorName+","+"startTime:"+startTime+","+"endTime:"+endTime+"],";
        }
        return projects;
    }

    /**
     * 用户注册
     * @param userName
     * @param userAccount
     * @param email
     * @param pwd
     */
    @Override
    public void add(String userName, String userAccount, String email, String pwd)  {
        try {
            Conn conn = new Conn();
            con = conn.getCon();
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 计算md5函数
            md.update(pwd.getBytes());
            pwd = String.valueOf(new BigInteger(1, md.digest()).toString(16));
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO `javaweb`.`users` (`userName`, `userAuthority`, `userEmail`,`joinDate`, `userAccount`, `userPwd`) " + "VALUES (?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, userName);
            pstmt.setString(2, "guess");
            pstmt.setString(3, email);
            pstmt.setDate(4, new java.sql.Date(System.currentTimeMillis()));
            pstmt.setString(5, userAccount);
            pstmt.setString(6, pwd);
            pstmt.execute();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 创建项目
     * @param proName
     * @throws SQLException
     */
    @Override
    public String createPro(String proName, String startTime, String endTime, String members)  {
//        完成插入
        try{
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd ");

        PreparedStatement pstmt = con.prepareStatement(
                "INSERT INTO `javaweb`.`projects` (`proName`, `creator`, `startTime`, `endTime`, `creatorName`) " +
                        "VALUES (?, ?, ?, ?, ?)");
        System.out.println(proName);
        System.out.println("userID:"+this.currentUser.getUserID());

        pstmt.setString(1, proName);

        pstmt.setInt(2, this.currentUser.getUserID());

        //项目截止时间应在开始时间之后
        if(java.sql.Date.valueOf(startTime).after(java.sql.Date.valueOf(endTime))){
            return "Wrong time!";
        }
        pstmt.setDate(3, java.sql.Date.valueOf(startTime));

        pstmt.setDate(4, java.sql.Date.valueOf(endTime));

        pstmt.setString(5, this.currentUser.getName());

        System.out.println("name:"+this.currentUser.getName());
        pstmt.execute();

//        查询项目参与者的名字
        PreparedStatement pstmt1 = con.prepareStatement("SELECT proID FROM projects WHERE proName = ?");
        pstmt1.setString(1, proName );
        System.out.println(proName);
        rs = pstmt1.executeQuery();
        rs.next();
        int proID = rs.getInt("proID");
        members += ","+this.currentUser.getUserID()+",";
        String mm[] = members.split(",");
        String result = "";
//        存疑
        for(String m : mm){
//            查找userName
            PreparedStatement pstmt2 = con.prepareStatement("SELECT userName FROM users WHERE userID = ?");
            System.out.println(m);
            pstmt2.setInt(1, Integer.parseInt(m) );
            rs = pstmt2.executeQuery();
            rs.next();
            String userName = "";
            try {
                userName = rs.getString("userName");
            }catch (Exception e)
            {
                result += "用户"+m+"不存在!";
            }
            System.out.println("============"+userName);
//            往joininfo表中添加参与项目信息
            java.util.Date date = new java.util.Date();
            joinPro(m.trim(),String.valueOf(proID), formatter.format(date),proName,userName);
        }
        return "Create Successful!\n"+result;
        }catch (Exception e)
        {
            e.printStackTrace();
            return "Create Failed!";
        }
    }


    /**
     * 用户参与项目
     * @param userID
     */
    @Override
    public void joinPro(String userID, String proID, String joinDate, String proName, String userName) throws SQLException {
        PreparedStatement pstmt = con.prepareStatement(
                "INSERT INTO `javaweb`.`joininfo` (`userID`, `proID`, `joinDate`, `proName`, `userName`) " +
                        "VALUES (?, ?, ?, ?, ?)");
        pstmt.setInt(1, Integer.parseInt(userID));
        pstmt.setInt(2, Integer.parseInt(proID));
        pstmt.setDate(3, new Date(System.currentTimeMillis()));
        pstmt.setString(4, proName);
        pstmt.setString(5, userName);
        pstmt.execute();
    }


    /**
     * 用户退出项目
     * @param task
     */
    @Override
    public void quitPro(Task task) throws SQLException {
        PreparedStatement pstmt = con.prepareStatement(
                "DELETE FROM `javaweb`.`joininfo` WHERE (`userID` = ? AND `proID` = ?)");
        pstmt.setInt(1, currentUser.getUserID());
        pstmt.setInt(2, task.getProID());
        rs = pstmt.executeQuery();
    }

    /**
     * 用户更改密码
     * 使用MD5加密
     * @param pwd
     */
    @Override
    public void changePwd(String pwd) {

    }

    /**
     * 退出登录
     */
    @Override
    public void loginOut() {
        con = null;
        sql = null;
        rs = null;
        currentUser = null;
    }


    /**
     * 删除项目
     * 需要删除项目表和信息表中的信息
     * 以下方法为管理员操作
     * @param proID
     */
    public void deletedPro(String proID) throws SQLException {
        try {
            System.out.println(proID);
            PreparedStatement pstmt0 = con.prepareStatement("DELETE FROM projects WHERE proID = ?");
            pstmt0.setInt(1, Integer.parseInt(proID));
            PreparedStatement pstmt1 = con.prepareStatement("DELETE FROM joininfo WHERE proID = ?");
            pstmt1.setInt(1, Integer.parseInt(proID));
            pstmt0.execute();
            pstmt1.execute();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 删除用户
     * 需要删除用户表和信息表的数据
     */
    public void deleteUser(String userID)  {
        try {
            PreparedStatement pstmt0 = con.prepareStatement("DELETE FROM users WHERE userID = ?");
            pstmt0.setInt(1, Integer.parseInt(userID));
            PreparedStatement pstmt1 = con.prepareStatement("DELETE FROM joininfo WHERE userID = ?");
            pstmt1.setInt(1, Integer.parseInt(userID));
            pstmt0.execute();
            pstmt1.execute();
        }catch (Exception e)
        {
            e.printStackTrace();
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

}
