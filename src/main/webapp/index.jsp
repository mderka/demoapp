<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gcloud.dns.Zone" %>
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

    <title>Martin's demo app</title>

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
            <a class="navbar-brand" href="/">Martin's demo app</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/">Home</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<div class="container">

    <div class="starter-template">
        <h1>Demo app for gcloud-java-dns (intern project)</h1>
        <p class="lead">This is a quick demo app implemented using gcloud-java-dns.</p>
    </div>

    <% if(request.getParameter("added") != null) {%>
    <div class="alert alert-success">Zone was successfully added.</div>
    <%}%>
    <% if(request.getParameter("delete") != null) {%>
        <div class="alert alert-info">Zone was successfully deleted.</div>
     <%}%>

    <table class="table">
        <thead>
        <tr>
            <th>#</th>
            <th>Managed Zone</th>
            <th>Domain</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%for(Zone zone : Controller.getZones()){%>
            <tr>
            <td></td>
            <td><%=zone.name()%></td>
            <td><%=zone.dnsName()%></td>
            <td><%=zone.description()%></td>
            <td>
                <a href="detail?name=<%=zone.name()%>" class="btn btn-default btn-sm">Details</a>
                <a href="deleteZone?zone=<%=zone.name()%>" class="btn btn-default btn-sm">Delete</a>
            </td>
            </tr>
        <%}%>
        </thead>
    </table>


<div class="row">
<div class="col-md-3"></div>
<div class="col-md-6">
<form action="addZone" method="GET">
  <fieldset class="form-group">
    <label for="name">Zone Name</label>
    <input type="text" class="form-control" id="name" name="name" placeholder="new zone name">
  </fieldset>
  <fieldset class="form-group">
      <label for="domain">Domain Name</label>
      <input type="text" class="form-control" id="domain" name="domain" placeholder="example.com.">
    </fieldset>
  <fieldset class="form-group">
    <label for="description">Description</label>
    <input type="text" class="form-control" id="description" name="description" placeholder="description....">
  </fieldset>
   <button type="submit" class="btn btn-primary pull-right">Add Zone</button>
 </form>
 </div>
</div>


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

