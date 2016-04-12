package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;

/**
 * Created by derka on 4/12/16.
 */
public class DeleteRecord extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String zoneName = request.getParameter("zone");
    String recordName = request.getParameter("record");
    String recordType = request.getParameter("type");
    Controller.deleteRecord(zoneName, recordName, recordType);
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.sendRedirect("detail?name=" + zoneName);
  }
}
