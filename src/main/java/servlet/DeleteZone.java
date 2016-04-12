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
public class DeleteZone extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String zoneName = request.getParameter("zone");
    Controller.deleteZone(zoneName);
    response.sendRedirect("/?delete=true");
  }
}
