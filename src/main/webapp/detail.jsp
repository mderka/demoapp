<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gcloud.dns.RecordSet" %>
<%@ page import="com.google.gcloud.dns.Zone" %>
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
    <div class="alert alert-success">Change for adding the record was successfully created.</div>
    <%}%>
    <% if(request.getParameter("delete") != null) {%>
        <div class="alert alert-info">Change for deleting the record was successfully created.</div>
     <%}%>



  <div class="row">
  <div class="col-md-4">
      <h2>Zone Information</h2>
      <%

      Zone zone = Controller.getZone(request.getParameter("name"));

      out.println("<strong>Name:</strong> " + zone.name() + "<br>");
      out.println("<strong>Created:</strong> " + zone.creationTimeMillis() + "<br>");
      out.println("<strong>Domain:</strong> " + zone.dnsName() + "<br>");
      out.println("<strong>Description:</strong> " + zone.description() + "<br>");
      out.println("<strong>Nameservers:</strong><ol>");
      for(String s : zone.nameServers()) {
          out.println("<li>" + s + "</li>");
      }
      out.println("</ol>");
      %>

<br>
<br>
<br>
<h2>Add Records</h2>
<form action="addRecord" method="POST">
  <fieldset class="form-group">
    <label for="name">Name</label>
    <input type="text" class="form-control" id="name" name="name" placeholder="www.domain.com.">
  </fieldset>
  <fieldset class="form-group">
      <label for="type">Type</label>
      <input type="text" class="form-control" id="type" name="type" placeholder="A, AAAA,...">
  </fieldset>
  <fieldset class="form-group">
        <label for="value">Value</label>
        <input type="text" class="form-control" id="value" name="value" placeholder="255.255.225.255">
    </fieldset>
  <fieldset class="form-group">
    <label for="ttl">TTL</label>
    <input type="text" class="form-control" id="ttl" name="ttl" placeholder="21600">
  </fieldset>
   <input type="hidden" class="form-control" id="zoneName" name="zoneName" value="<%=request.getParameter("name")%>">
   <button type="submit" class="btn btn-primary pull-right">Add Record</button>
 </form>


  </div>
    <div class="col-md-1"></div>
    <div class="col-md-7">
    <h2>Record Sets</h2>
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
            <td><% out.println(rrset.records().get(0)); %></td>
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


    <h2>Changes</h2>
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

