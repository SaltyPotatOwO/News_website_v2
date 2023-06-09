
<%@page import="java.util.*"%>
<%@page import="model.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category</title>
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Embed Global CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
        <!-- Embed category CSS -->
        <link rel="stylesheet" href="css/styleCategory.css">
        <link rel="stylesheet" href="css/styleNewsInfo.css"/>
        <link rel="stylesheet" href="css/styleSearchResult.css"/>
    </head>

    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <!-- NAVBAR -->
                <div class="navbar-logo col-md-1">
                    <a class="navbar-brand" href="MainPage">
                        <img style="width: 100px;" src="image/branding/vice logo.png" alt="">
                    </a>
                </div>
                <!-- NAVBAR TOOGLER -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                        aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- NAVBAR CATEGORY -->
                <div class="collapse navbar-collapse col-md-6" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <%
                            HashMap<Integer,Category> cat_name = (HashMap<Integer,Category>) session.getAttribute("cat_list");
                            for (int key : cat_name.keySet()) {
                        %>
                        <div class="nav-item">
                            <a class="nav-link hover-animation-underline" href="Search?cat_id=<%= cat_name.get(key).getId() %>">
                                <%= cat_name.get(key).getName()%></a>
                        </div>
                        <%}%>
                    </ul>
                </div>
                <!-- NAVBAR SEARCH -->
                <div class="col-md-3 navbar-search">
                    <form action="Search">
                        <input style="width: 100%;height: 44px; border-radius: 100px; padding: 0px 20px" type="text" name="title" placeholder="Search anything">
                        <button style="border: 0px;" type="submit" class="rounded-circle nopadding">
                            <i class="material-icons hover-animation-grow">search</i>
                        </button>
                    </form>
                </div>

                <!-- NAVBAR PROFILE -->
                <div class="col-md-2 navbar-login navbar-collapse" id="navbarNavDropdown">
                    <% String user = "user";
                         int ID = 0;
                         if (session.getAttribute("user") != null) {  
                        User user1 = (User)session.getAttribute("user");
                        user = user1.getName();
                        ID = user1.getId();
                        }%>
                    <p class="nopadding">Hello, <%= user %></p>
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="dropdown-toggle" href="#" id="navbarDropdownMenuLink" id="navbar-icon-user"
                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="material-icons hover-animation-grow">person</i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
                                <!-- c�i n�y th?ng n�o l�m jsp th� ph�n lo?i theo ki?u ng??i d�ng -->
                                <% if (session.getAttribute("user") == null) {  %>
                                <li><a class="dropdown-item" href="login.jsp">Login</a></li>
                                <li><a class="dropdown-item" href="login.jsp">Sign up</a></li>
                                    <%} else{ %>
                                <li><a class="dropdown-item" href="UserLogout">Log out</a></li>
                                <li><a class="dropdown-item" href="Profile?id=<%= ID %>">Profile</a></li>
                                    <%}%>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- spacer for fixed navbar -->
        <div style="height: 84px;" class="spacer"></div>
        <%
            HashMap<Integer, User> user_nameList = (HashMap<Integer, User>) request.getAttribute("user_list");
            ArrayList<News> news_list = (ArrayList<News>) request.getAttribute("news_list");
            String title = (String) request.getAttribute("title");
        %>

        <!-- HEADING -->
        <div class="latest-title nopadding">
            <h1>Search result for</h1>
            <h1>"<%= title%>"</h1>
        </div>

        <div class="filter-box">
            <form action="Search" method="get">
                <input type="hidden" name="title" value="<%=title%>">
                <select name="cat_id">  
                    <option  value="" disabled selected >Select Category</option>
                    <c:forEach items="<%= cat_name%>" var = "cat_name" >
                        <option value="<c:out value="${cat_name.key}"/>" > <c:out value="${cat_name.value.getName()}"/> </option>
                    </c:forEach>
                </select>
                <input style="color: white; font-weight: bold" class="button-submit filter-box-button" type='submit' name='action' value='Filter'>
            </form>
        </div>
        <!-- MAIN-CONTENT -->
        <!-- them if neu ko co bai nao -->
        <div class="container-fluid">
            <!-- 4 rows of news -->
            <div class="row nopadding">
                <%
                for (News news : news_list) {
                %>
                <div class="card col-md-4 nopadding">
                    <a href="GetNews?news_id=<%= news.getNews_id()%>" ><img style="height: 300px; object-fit: cover" src="<%= session.getAttribute("location")%><%= news.getImage()%>" class="card-img-top" alt="..."></a>
                    <div class="card-body">
                        <a href="Search?cat_id=<%=news.getCat_id() %>"><h5 class="card-subtitle"><%= cat_name.get(news.getCat_id()).getName() %></a>
                        <a href="GetNews?news_id=<%= news.getNews_id()%>"><h3 class="card-title"><%= news.getTitle()%></h3></a>
                        <a href="GetNews?news_id=<%= news.getNews_id()%>"><p class="card-text"><%= news.getSubtitle()%></p></a>
                        <a class="author-info" href="publicUserInfo?user_id=<%= news.getUser_id()%>"><h6 class="card-text"><%= user_nameList.get(news.getUser_id()).getName()%></h6></a>
                    </div>
                </div>
                <%}%>
            </div>
        </div>


        <!-- FOOTER -->
        <div class="footer">
            <img class="rotate" style="width: 100px;" src="image/branding/VMG-logo-updated.png" alt="">
            <ul>
                <li>Tr?n Th? H?ng</li>
                <li>L? Th? L??ng</li>
                <li>Ph?ng Ph?c L?m</li>
                <li>Nguy?n Ho?ng Hi?p</li>
                <li>Nguy?n Ch? Trung</li>
            </ul>
            <p>@ 2023 PRj301 HE1725</p>
        </div>
    </body>

</html>