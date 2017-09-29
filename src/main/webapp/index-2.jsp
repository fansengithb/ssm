
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%--首页直接转到emps请求--%>
<jsp:forward page="/emps"></jsp:forward>
<html>
<head>
    <%--引入jquery--%>
        <script type="text/javascript"
                src="${APP_PATH }static/js/jquery-1.12.4.min.js"></script>
    <%--引入样式--%>
    <link
            href="${APP_PATH }static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<h2>Hello World!</h2>
<button class="btn btn-success">button</button>

</body>
</html>
