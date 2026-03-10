package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private Connection conn;

    public CartDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addToCart(int bookId, int userId) {
        boolean success = false;
        try {
            // Check if book already exists in cart
            String checkQuery = "SELECT * FROM cart WHERE user_id = ? AND book_id = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkQuery);
            checkPs.setInt(1, userId);
            checkPs.setInt(2, bookId);
            ResultSet rs = checkPs.executeQuery();

            if (!rs.next()) {
                String insertQuery = "INSERT INTO cart(user_id, book_id) VALUES(?, ?)";
                PreparedStatement ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, userId);
                ps.setInt(2, bookId);
                success = ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean removeFromCart(int bookId, int userId) {
        boolean success = false;
        try {
            String query = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            success = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<Integer> getCartBooksByUserId(int userId) {
        List<Integer> bookIds = new ArrayList<>();
        try {
            String query = "SELECT book_id FROM cart WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookIds.add(rs.getInt("book_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookIds;
    }

    public int getCartItemCount(int userId) {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) AS count FROM cart WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean clearCart(int userId) {
        boolean success = false;
        try {
            String query = "DELETE FROM cart WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            success = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}
