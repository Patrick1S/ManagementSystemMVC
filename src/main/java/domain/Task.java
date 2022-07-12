package domain;

import dao.IUserDao;

import java.util.Date;

public class Task {
    /**
     * 任务类
     */
    int proID ;
    String proName ;
    IUserDao creator ;
    Date startTime ;
    Date endTime ;

    public int getProID() {
        return proID;
    }

    public void setProID(int proID) {
        this.proID = proID;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public IUserDao getCreator() {
        return creator;
    }

    public void setCreator(IUserDao creator) {
        this.creator = creator;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}
