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
public class AddZone extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String name = request.getParameter("name");
    String domain = request.getParameter("domain");
    String description = request.getParameter("description");
    Controller.addZone(name, domain, description);
    response.sendRedirect("/?added=true");
  }
}
