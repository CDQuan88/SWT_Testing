/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Luu Bach
 */
public class Attendance implements IBaseModel {

    private Session session;
    private Student student;
    private boolean status;
    private String description;
    private Date att_datetime;

    public Attendance() {
    }

    public Session getSession() {
        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getAtt_datetime() {
        return att_datetime;
    }

    public void setAtt_datetime(Date att_datetime) {
        this.att_datetime = att_datetime;
    }

}
