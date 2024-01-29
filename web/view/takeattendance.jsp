<%-- 
    Document   : att
    Created on : Oct 23, 2023, 4:14:23 PM
    Author     : sonnt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style/take_attendance.css"/>
        <title>Take Attendance</title>
    </head>
    <body>
        <header>
            <div class="Header">Take Attendance</div>
        </header>
        <div class="left-header" id="header">
            <div class="header-text">
                <img src="img/logo-fpt-university.jpg" alt="logo-fpt"/>
            </div>
            <div class="menu-item" id="home">
                <img src="img/home-icon.png" alt="Home" style="display: inline-block; vertical-align: middle;width:30%;margin-top: -10px;margin-left: -10px;"/>
                <a href="view/home.jsp" style="margin-left: -27px;">Home</a>
            </div>
            <div class="menu-item" id="schedule">
                <img src="img/calendar-icon.png" alt="Home" style="display: inline-block; vertical-align: middle;width:30%;margin-left: -12px;margin-top: -10px"/>
                <a href="timetable?iid=${sessionScope.iid}" style="margin-left: -27px;">Schedule</a>
            </div>
            <div class="menu-item" id="attendance">
                <img src="img/report-icon.png" alt="Home" style="display: inline-block; vertical-align: middle;width:27%;margin-top: -7px;margin-left: -10px;"/>
                <a href="view-attendance" style="margin-left: -27px;">Report</a>
            </div>
            <div class="menu-item" id="logout">
                <img src="img/logout-icon.png" alt="Home" style="display: inline-block; vertical-align: middle;width:28%;margin-top:-8px;margin-left: -7px;"/>
                <a href="logout" style="margin-left: -27px;">Log out</a>
            </div>
            <div class="menu-item">
                <div class="icon-home">
                    <div id="username">
                        <img src="img/icon-user.png" alt="Home" style="display: inline-block; vertical-align: middle;width:30%;margin-top: 5px;margin-left: -10px;"/>
                        <p style="display: inline-block; vertical-align: middle;color: black;margin-left: -27px;">${sessionScope.username}</p>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const home = document.getElementById('home');
            const schedule = document.getElementById('schedule');
            const attendance = document.getElementById('attendance');
            const username = document.getElementById('username');
            const logout = document.getElementById('logout');

            home.addEventListener('mouseover', function () {
                home.style.backgroundColor = 'chocolate';
            });

            home.addEventListener('mouseout', function () {
                home.style.backgroundColor = '';
            });

            schedule.addEventListener('mouseover', function () {
                schedule.style.backgroundColor = 'chocolate';
            });

            schedule.addEventListener('mouseout', function () {
                schedule.style.backgroundColor = '';
            });

            attendance.addEventListener('mouseover', function () {
                attendance.style.backgroundColor = 'chocolate';
            });

            attendance.addEventListener('mouseout', function () {
                attendance.style.backgroundColor = '';
            });

            logout.addEventListener('mouseover', function () {
                logout.style.backgroundColor = 'chocolate';
            });

            logout.addEventListener('mouseout', function () {
                logout.style.backgroundColor = '';
            });
        </script>
        <div style="margin-left: 15%;margin-top: 200px;">
            Class:${requestScope.ses.group.name}-${requestScope.ses.group.subject.name}-${requestScope.ses.room.id}
            <form action="attend" method="POST">
                <table border="1px">
                    <tr>
                        <td>Student</td>
                        <td>Status</td>
                        <td>Description</td>
                        <td>Taking Time</td>
                    </tr>
                    <c:forEach items="${requestScope.attends}" var="a">
                        <tr>
                            <td>
                                ${a.student.name}
                                <input type="hidden" name="stuid" value="${a.student.id}"/>
                            </td>
                            <td>
                                <input type="radio"
                                       <c:if test="${!a.status}">
                                           checked="checked"
                                       </c:if>
                                       name="status${a.student.id}" value="absent" /> absent
                                <input type="radio"
                                       <c:if test="${a.status}">
                                           checked="checked"
                                       </c:if>
                                       name="status${a.student.id}" value="present" /> present
                            </td>
                            <td><input type="text" value="${a.description}" name="description${a.student.id}"/></td>
                            <td>${a.att_datetime}</td>
                        </tr>   
                    </c:forEach>
                </table>
                <input type="hidden" value="${requestScope.ses.id}" name="sesid"/>
                <div style="text-align: center;">
                    <input type="submit" value="Save"/>
                </div>            
            </form>
        </div>
    </body>
</html>
