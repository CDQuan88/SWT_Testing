/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.assignment.GroupDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Attendance;
import model.Group;
import model.Session;
import model.Student;
import model.StudentReport;

/**
 *
 * @author Luu Bach
 */
public class ViewAttendanceController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int iid = (int) request.getSession().getAttribute("iid");
        GroupDBContext groupDB = new GroupDBContext();
        ArrayList<Group> groups = groupDB.list(iid);
        request.setAttribute("groups", groups);
        request.getRequestDispatcher("view/viewattendance.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int iid = (int) request.getSession().getAttribute("iid");
        GroupDBContext groupDB = new GroupDBContext();
        ArrayList<Group> groups = groupDB.list(iid);
        request.setAttribute("groups", groups);
        String class_raw = request.getParameter("class");
        String[] values = class_raw.split("-");
        String groupName_raw = values[0];       // Separate variable for g.name
        String subjectName_raw = values[1];     // Separate variable for g.subject.name
        // Create a DecimalFormat object with two decimal places
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        try {
            Group groupViewAtt = groupDB.listViewAttendance(groupName_raw, subjectName_raw);
            for (Student st : groupViewAtt.getStudents()) {
                float absent = 0;
                StudentReport report = new StudentReport();
                for (Session ses : groupViewAtt.getSessions()) {
                    for (Attendance att : ses.getAtts()) {
                        if (att.getStudent().getId() == st.getId() && !att.isStatus() && ses.isIsAttend()) {
                            absent++;
                        }
                    }
                }
                report.setGroup(groupViewAtt);
                String formattedValue = decimalFormat.format(absent * 100 / groupViewAtt.getSessions().size());
                float absentPercent = Float.parseFloat(formattedValue);
                report.setAbsentPercent(absentPercent);
                report.setStudent(st);
                st.setReport(report);
            }
            request.setAttribute("group", groupViewAtt);
            request.getRequestDispatcher("view/viewattendance.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewAttendanceController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
