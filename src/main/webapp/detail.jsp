<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gcloud.dns.RecordSet" %>
<%@ page import="com.google.gcloud.dns.ChangeRequest" %>
<%@ page import="controller.Controller" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Starter Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/starter-template.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<div class="container">

    <div class="starter-template">
        <h1>Bootstrap starter template</h1>
        <p class="lead">Use this document as a way to quickly start any new project.<br> All you get
            is this text and a mostly barebones HTML document.</p>
    </div>

    <h2>Record Sets in <%=request.getParameter("name")%></h2>
    <table class="table">
        <thead>
        <tr>
            <th>#</th>
            <th>Type</th>
            <th>Name</th>
            <th>Values</th>
            <th>TTL</th>
            <th>Actions</th>
        </tr>
<%  int counter = 0;
    for(RecordSet rrset : Controller.getRecords(request.getParameter("name"))){%>
            <tr>
            <td><%=counter%></td>
            <td><%=rrset.type()%></td>
            <td><%=rrset.name()%></td>
            <td></td>
            <td><%=rrset.ttl()%></td>
            <td>
                <a href="deleteRecord?zone=<%=request.getParameter("name")%>&record=<%=rrset.name()%>&type=<%=rrset.type()%>"
                class="btn btn-default btn-sm">Delete</a>
            </td>
            </tr>
<%    counter++;
    }%>
        </thead>
    </table>

    <h2>Changes in <%=request.getParameter("name")%></h2>
    <table class="table">
        <thead>
        <tr>
            <th>#</th>
            <th>Additions</th>
            <th>Deletions</th>
            <th>Status</th>
        </tr>
<%for(ChangeRequest change : Controller.getChanges(request.getParameter("name"))){%>
            <tr>
            <td><%=change.generatedId()%></td>
            <td>
            <% if(change.additions().size() > 0) {%>
              [<%=change.additions().get(0).type()%>] <%=change.additions().get(0).name()%>
             <%}%>
            </td>
            <td>
            <% if(change.deletions().size() > 0) {%>
                          [<%=change.deletions().get(0).type()%>] <%=change.deletions().get(0).name()%>
                         <%}%>
            </td>
            <td><%=change.status()%></td>
            </tr>
        <%}%>
        </thead>
    </table>

    <form>



</div><!-- /.container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
    window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')
</script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>

