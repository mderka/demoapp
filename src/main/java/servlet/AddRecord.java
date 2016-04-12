package servlet;

import com.google.gcloud.dns.RecordSet;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;

/**
 * Created by derka on 4/12/16.
 */
public class AddRecord extends HttpServlet {

  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String zoneName = request.getParameter("zoneName");
    String name = request.getParameter("name");
    String type = request.getParameter("type");
    String value = request.getParameter("value");
    String ttl = request.getParameter("ttl");
    RecordSet recordSet = RecordSet.builder(name, RecordSet.Type.valueOf(type)).addRecord(value)
        .ttl(Integer.parseInt(ttl), TimeUnit.SECONDS).build();
    Controller.addRecord(zoneName, recordSet);
    response.sendRedirect("detail?name=" + zoneName + "&added=true");
  }
}
