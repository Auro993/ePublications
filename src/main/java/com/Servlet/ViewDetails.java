package com.servlet;

import com.dao.BookDAO;
import com.db.DBConnect;
import com.user.Book;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ViewDetails")
public class ViewDetails extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            BookDAO bookDAO = new BookDAO(DBConnect.getConn());
            Book book = bookDAO.getBookById(bookId);
            HttpSession session = request.getSession();
            if(book != null) {
                session.setAttribute("bookDetails", book);
                response.sendRedirect("bookDetails.jsp");
            } else {
                session.setAttribute("errorMsg", "Book not found!");
                response.sendRedirect("home.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Something went wrong!");
            response.sendRedirect("home.jsp");
        }
    }
}