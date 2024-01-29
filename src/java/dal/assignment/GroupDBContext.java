/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.assignment;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Attendance;
import model.Group;
import model.Session;
import model.Student;
import model.Subject;

/**
 *
 * @author Luu Bach
 */
public class GroupDBContext extends DBContext<Group> {

    @Override
    public void insert(Group model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Group model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void remove(Group model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Group get(Group model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Group> list(int iid) {
        ArrayList<Group> groups = new ArrayList<>();
        try {
            String sql = "USE FALL2023_Assignment\n"
                    + "SELECT g.gname, s.subname,g.sup_iis\n"
                    + "FROM [Group] g\n"
                    + "INNER JOIN Subject s ON g.subid = s.subid\n"
                    + "WHERE g.sup_iis= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, iid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                g.setName(rs.getString("gname"));
                Subject s = new Subject();
                s.setName(rs.getString("subname"));
                g.setSubject(s);
                groups.add(g);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groups;
    }

    public Group listViewAttendance(String gname, String subname) throws SQLException {
        Group group = new Group();
        ArrayList<Student> students = getStudentsInGroup(gname, subname);
        ArrayList<Session> sessions = new ArrayList<>();
        int groupSize = students.size();
        String sql
                = "SELECT g.gname, s.subname, ses.[index], stu.stuname,stu.stuid , a.status,ses.isAtt\n"
                + "FROM [Group] g\n"
                + "INNER JOIN Subject s ON g.subid = s.subid\n"
                + "INNER JOIN Group_Student gs ON gs.gid = g.gid\n"
                + "INNER JOIN Student stu ON stu.stuid = gs.stuid\n"
                + "INNER JOIN Session ses ON ses.gid = g.gid\n"
                + "INNER JOIN Attendance a ON ses.sesid = a.sesid AND a.stuid = stu.stuid\n"
                + "WHERE g.gname = ? AND s.subname = ?\n"
                + "ORDER BY ses.[index];";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, gname);
        stm.setString(2, subname);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            ArrayList<Attendance> attendances = new ArrayList<>();
            Session ses = new Session();
            ses.setIndex(rs.getInt("index"));
            ses.setAtts(attendances);
            ses.setIsAttend(rs.getBoolean("isAtt"));
            sessions.add(ses);
            Student stu = new Student();
            stu.setId(rs.getInt("stuid"));
            stu.setName(rs.getString("stuname"));
            Attendance att = new Attendance();
            att.setStudent(stu);
            att.setStatus(rs.getBoolean("status"));
            attendances.add(att);
            for (int i = 1; i <= groupSize - 1; i++) {
                if (rs.next()) {
                    Student stu_next = new Student();
                    stu_next.setId(rs.getInt("stuid"));
                    stu_next.setName(rs.getString("stuname"));
                    Attendance att_next = new Attendance();
                    att_next.setStudent(stu_next);
                    att_next.setStatus(rs.getBoolean("status"));
                    attendances.add(att_next);
                }
            }
        }
        group.setSessions(sessions);
        group.setStudents(students);
        return group;
    }

    private ArrayList<Student> getStudentsInGroup(String gname, String subname) throws SQLException {
        ArrayList<Student> students = new ArrayList<>();
        String sql = "SELECT g.gid,g.gname, stu.stuid,stu.stuname \n"
                + "FROM [Group] g\n"
                + "INNER JOIN Group_Student gs ON gs.gid= g.gid\n"
                + "INNER JOIN Student stu ON stu.stuid= gs.stuid\n"
                + "WHERE g.gname=?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, gname);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Student stu = new Student();
            stu.setId(rs.getInt("stuid"));
            stu.setName(rs.getString("stuname"));
            students.add(stu);
        }
        return students;
    }

    @Override
    public ArrayList<Group> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
