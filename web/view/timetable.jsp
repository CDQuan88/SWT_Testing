<%-- 
    Document   : timetable
    Created on : Oct 18, 2023, 2:16:05 PM
    Author     : sonnt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Schedule</title>
        <link rel="stylesheet" type="text/css" href="style/timetable.css">
    </head>
    <body>
        <header>
            <div class="Header">Schedule</div>
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
        <div class="time-table">
            <div style="">
                <form action="timetable" method="GET">
                    <input type="hidden" name="iid" value="${sessionScope.iid}"/>
                    From <input type="date" value="${requestScope.from}" name="from"/> 
                    To <input type="date" value="${requestScope.to}" name="to"/> 
                    <input type="submit" value="View"/>
                </form>
            </div>
            <table id="table-date" border="1px" style="overflow-x:auto; ">
                <tr>
                    <th>Slot</th>
                        <c:forEach items="${requestScope.dates}" var="d">
                        <th>
                            ${d}
                        </th>
                    </c:forEach>
                </tr>
                <c:forEach items="${requestScope.slots}" var="s">
                    <tr>
                        <td>${s.id}.${s.description}</td>
                        <c:forEach items="${requestScope.dates}" var="d">
                            <td>
                                <c:forEach items="${requestScope.sessions}" var="k">
                                    <c:if test="${k.date eq d and k.slot.id eq s.id}">
                                        <a href="attend?id=${k.id}">
                                            ${k.group.name}-${k.group.subject.name}-${k.room.id}
                                            <c:if test="${k.isAttend}">
                                                (attended)
                                            </c:if>
                                            <c:if test="${!k.isAttend}">
                                                (not yet)
                                            </c:if>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
