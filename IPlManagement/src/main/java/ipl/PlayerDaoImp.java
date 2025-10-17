package ipl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlayerDaoImp implements PlayerDao {

    // ✅ Check if player with same jersey number exists for the team
    public boolean playerExists(int jerseyNumber, String teamCode) {
        String sql = "SELECT 1 FROM players WHERE jerseyNumber=? AND teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jerseyNumber);
            ps.setString(2, teamCode);
            ResultSet rs = ps.executeQuery();

            return rs.next(); // exists if any row returned

        } catch (SQLException e) {
            System.err.println("❌ Error checking existing player: " + e.getMessage());
        }
        return false;
    }

    // ✅ Add new player (preventing duplicate jersey number for same team)
    @Override
    public boolean addPlayer(Player player) {
        if (playerExists(player.getJerseyNumber(), player.getTeamCode())) {
            return false; // prevent duplicate
        }

        String sql = "INSERT INTO players (jerseyNumber, playerName, age, role, nationality, teamCode, imagePath) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, player.getJerseyNumber());
            ps.setString(2, player.getPlayerName());
            ps.setInt(3, player.getAge());
            ps.setString(4, player.getRole());
            ps.setString(5, player.getNationality());
            ps.setString(6, player.getTeamCode());
            ps.setString(7, player.getImagePath());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error adding player: " + e.getMessage());
        }
        return false;
    }

    // ✅ Update player details
    @Override
    public boolean updatePlayer(Player player) {
        String sql = "UPDATE players SET playerName=?, age=?, role=?, nationality=?, imagePath=? WHERE jerseyNumber=? AND teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, player.getPlayerName());
            ps.setInt(2, player.getAge());
            ps.setString(3, player.getRole());
            ps.setString(4, player.getNationality());
            ps.setString(5, player.getImagePath());
            ps.setInt(6, player.getJerseyNumber());
            ps.setString(7, player.getTeamCode());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error updating player: " + e.getMessage());
        }
        return false;
    }

    // ✅ Delete player
    @Override
    public boolean deletePlayer(int jerseyNumber, String teamCode) {
        String sql = "DELETE FROM players WHERE jerseyNumber=? AND teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jerseyNumber);
            ps.setString(2, teamCode);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error deleting player: " + e.getMessage());
        }
        return false;
    }

    // ✅ Get a single player by jersey number and team
    @Override
    public Player getPlayerByJersey(int jerseyNumber, String teamCode) {
        String sql = "SELECT * FROM players WHERE jerseyNumber=? AND teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jerseyNumber);
            ps.setString(2, teamCode);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapPlayer(rs);

        } catch (SQLException e) {
            System.err.println("❌ Error fetching player: " + e.getMessage());
        }
        return null;
    }

    // ✅ Get all players for a specific team
    @Override
    public List<Player> getPlayersByTeam(String teamCode) {
        List<Player> list = new ArrayList<>();
        String sql = "SELECT * FROM players WHERE teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, teamCode);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapPlayer(rs));

        } catch (SQLException e) {
            System.err.println("❌ Error fetching players by team: " + e.getMessage());
        }
        return list;
    }

    // ✅ Get all players
    @Override
    public List<Player> getAllPlayers() {
        List<Player> list = new ArrayList<>();
        String sql = "SELECT * FROM players";
        try (Connection con = DBUtil.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) list.add(mapPlayer(rs));

        } catch (SQLException e) {
            System.err.println("❌ Error fetching all players: " + e.getMessage());
        }
        return list;
    }

    // ✅ Helper method to map ResultSet to Player object
    private Player mapPlayer(ResultSet rs) throws SQLException {
        Player p = new Player();
        p.setJerseyNumber(rs.getInt("jerseyNumber"));
        p.setPlayerName(rs.getString("playerName"));
        p.setAge(rs.getInt("age"));
        p.setRole(rs.getString("role"));
        p.setNationality(rs.getString("nationality"));
        p.setTeamCode(rs.getString("teamCode"));
        p.setImagePath(rs.getString("imagePath"));
        return p;
    }
}
