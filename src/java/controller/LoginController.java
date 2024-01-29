
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.assignment.AdminDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;

/**
 *
 * @author Luu Bach
 */
public class LoginController extends HttpServlet {

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
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AdminDBContext a = new AdminDBContext();
        String remember = request.getParameter("remember");
        String username_raw = request.getParameter("username");
        String password_raw = request.getParameter("password");
        Admin ad = new Admin();
        ad.setUsername(username_raw);
        ad.setPassword(password_raw);
        if (a.get(ad) == null) {
            String invalidAccount = "Invalid username or password";
            request.setAttribute("invalidAccount", invalidAccount);
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        } else {
            if (remember != null) {
                Cookie c_user = new Cookie("user", username_raw);
                Cookie c_pass = new Cookie("pass", password_raw);
                c_user.setMaxAge(24 * 3600);
                c_pass.setMaxAge(24 * 3600);
                response.addCookie(c_user);
                response.addCookie(c_pass);
            }
            HttpSession session = request.getSession();
            session.setAttribute("iid", a.get(ad).getId());
            session.setAttribute("username", username_raw);
            response.sendRedirect("view/home.jsp");
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
