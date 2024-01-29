<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="style/login.css">
        <title>Login Form</title>
    </head>
    <body>
        <c:set var="cookies" value="${pageContext.request.cookies}"/>
        <div class="wrapper">
            <div class="login-container">
                <img src="img/LOGO-FPT-University-login.jpg"/>
                <form action="login" method="post">
                    <input type="text" class="login-input" placeholder="Username" name="username" value="${cookie.user.value}">
                    <input type="password" class="login-input" placeholder="Password" name="password" value="${cookie.pass.value}">
                    <div class="remember-section">
                        <input type="checkbox" name="remember" value="remember" id="remember-checkbox">
                        <label for="remember-checkbox">Remember in this computer.</label>
                    </div><br>
                    <div>
                        <c:if test="${requestScope.invalidAccount != null}">
                            <p style="color:red">${invalidAccount}</p>
                        </c:if>
                    </div>
                    <button class="login-btn" type="submit">LOGIN</button>
                </form>
            </div>
        </div>
        <script>
            document.querySelector(".login-btn").addEventListener("mouseenter", function () {
                this.style.backgroundColor = "#004999";
                this.style.color = "#ffffff";
            });

            document.querySelector(".login-btn").addEventListener("mouseleave", function () {
                this.style.backgroundColor = "";
                this.style.color = "";
            });
            let inputs = document.querySelectorAll(".login-input");
            inputs.forEach(input => {
                input.addEventListener("mouseenter", function () {
                    this.style.boxShadow = "0 0 5px #007BFF";
                });
                input.addEventListener("mouseleave", function () {
                    this.style.boxShadow = "";
                });
            });
        </script>
    </body>
</html>
