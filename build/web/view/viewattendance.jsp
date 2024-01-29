<%--
Document : viewattendance
Created on : Oct 28, 2023, 8:03:56 PM
Author : Luu Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style/view-attendance.css">
        <title>View Attendance</title>
    </head>
    <body>
        <header>
            <div class="Header">Report</div>
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
        <div class="Content" style="margin-left: 15%;">
            <div class="choose-class">
                <form action="view-attendance" method="POST">
                    <table border="1px">
                        <tr>
                            <th>Class</th>
                        </tr>
                        <c:forEach items="${requestScope.groups}" var="g">
                            <tr>
                                <td><input type="radio" name="class"
                                           value="${g.name}-${g.subject.name}" />${g.name}-${g.subject.name}
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="submit-button">
                        <input type="submit" value="View"  />
                    </div> 
                </form>
            </div>
            <div class="report-table">
                <table border="1px">
                    <tr>
                        <th>Student Id</th>
                        <th>Student Name</th>
                            <c:forEach items="${requestScope.group.sessions}"
                                       var="ses">
                            <th>Lesson No.${ses.index}</th>
                            </c:forEach>
                        <th>Total Absent</th>
                    </tr>
                    <c:forEach items="${requestScope.group.students}" var="stu">
                        <tr>
                            <td>${stu.id}</td>
                            <td>${stu.name}</td>
                            <c:forEach items="${requestScope.group.sessions}" var="ses">
                                <c:forEach items="${ses.atts}" var="att">
                                    <c:choose>
                                        <c:when test="${!ses.isAttend && att.student.id eq stu.id}">
                                            <td style="color: gray;">not yet</td>
                                        </c:when>
                                        <c:when test="${att.student.id eq stu.id && att.status}">
                                            <td style="color: chartreuse">present</td>
                                        </c:when>
                                        <c:when test="${att.student.id eq stu.id && !att.status}">
                                            <td style="color:red">absent</td>
                                        </c:when>    
                                    </c:choose>
                                </c:forEach>
                            </c:forEach>
                            <td <c:choose> 
                                    <c:when test="${stu.report.absentPercent > 20}">
                                        style="color: red"
                                    </c:when>
                                    <c:when test="${!requestScope.group.finished}" >
                                        style="color: gray"
                                    </c:when>
                                    <c:when test="${requestScope.group.finished && stu.report.absentPercent <= 20}">
                                        style="color: green"
                                    </c:when>    
                                </c:choose>>
                                ${stu.report.absentPercent}%
                            </td>                            
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="report-hint">
                <p><span class="dot green-dot"></span> - Accepted</p>
                <p><span class="dot red-dot"></span> - Rejected</p>
                <p><span class="dot gray-dot"></span> - In Progress</p>
            </div>
        </div>
    </body>
</html>
