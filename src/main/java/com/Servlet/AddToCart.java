package com.servlet;

import com.dao.CartDAO;
import com.db.DBConnect;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Integer userId = (Integer) session.getAttribute("userId");

            // TEMPORARY FIX: Use demo user ID
            if (userId == null) {
                userId = 1; // Use demo user ID
                session.setAttribute("userId", userId);
            }

            CartDAO dao = new CartDAO(DBConnect.getConn());
            boolean success = dao.addToCart(bookId, userId);

            if (success) {
                session.setAttribute("successMsg", "Book added to cart!");
                
                // UPDATE CART COUNT IN SESSION
                int cartCount = dao.getCartItemCount(userId);
                session.setAttribute("cartCount", cartCount);
                
            } else {
                session.setAttribute("errorMsg", "Book already in cart!");
            }
            response.sendRedirect("home.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Error: " + e.getMessage());
            response.sendRedirect("home.jsp");
        }
    }
}