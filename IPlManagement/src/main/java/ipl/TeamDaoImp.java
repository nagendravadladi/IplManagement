package ipl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeamDaoImp {

    // ✅ Helper method to check if a team code already exists
    public boolean teamExists(String teamCode) {
        String sql = "SELECT 1 FROM teams WHERE teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, teamCode);
            ResultSet rs = ps.executeQuery();

            return rs.next(); // true if a row is returned (team exists)

        } catch (SQLException e) {
            System.err.println("❌ Error checking existing team: " + e.getMessage());
            return false;
        }
    }
    
    // ✅ Add team (now returns boolean and checks for duplicates)
    public boolean addTeam(Team team) {
        // Explicitly check for duplicate before attempting insert
        if (teamExists(team.getTeamCode())) {
            return false; // Team already exists
        }
        
        String sql = "INSERT INTO teams (teamCode, teamName, country, coachName, captainName, logoPath) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, team.getTeamCode());
            ps.setString(2, team.getTeamName());
            ps.setString(3, team.getCountry());
            ps.setString(4, team.getCoachName());
            ps.setString(5, team.getCaptainName());
            ps.setString(6, team.getLogoPath());

            return ps.executeUpdate() > 0; // Returns true if one row was inserted

        } catch (SQLException e) {
            System.err.println("❌ Error adding team: " + e.getMessage());
        }
        return false;
    }

    // ✅ Update team (now returns boolean)
    public boolean updateTeam(Team team) {
        String sql = "UPDATE teams SET teamName=?, country=?, coachName=?, captainName=?, logoPath=? WHERE teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, team.getTeamName());
            ps.setString(2, team.getCountry());
            ps.setString(3, team.getCoachName());
            ps.setString(4, team.getCaptainName());
            ps.setString(5, team.getLogoPath());
            ps.setString(6, team.getTeamCode());

            return ps.executeUpdate() > 0; // Returns true if one row was updated
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating team: " + e.getMessage());
        }
        return false;
    }

    // ✅ Delete team (now returns boolean)
    public boolean deleteTeam(String code) {
        String sql = "DELETE FROM teams WHERE teamCode=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, code);
            
            return ps.executeUpdate() > 0; // Returns true if one row was deleted
            
        } catch (SQLException e) {
            System.err.println("❌ Error deleting team: " + e.getMessage());
        }
        return false;
    }
    
    // -----------------------------------------------------------
    // Getter Methods (Refactored for consistency)
    // -----------------------------------------------------------

    // ✅ Get team by code (uses try-with-resources)
    public Team getTeamByCode(String code) {
        Team team = null;
        String sql = "SELECT * FROM teams WHERE teamCode=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                team = mapTeam(rs);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching team by code: " + e.getMessage());
        }

        return team;
    }
    
    // ✅ Get all teams (uses try-with-resources)
    public List<Team> getAllTeams() {
        List<Team> list = new ArrayList<>();
        String sql = "SELECT * FROM teams";

        try (Connection con = DBUtil.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapTeam(rs));
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching all teams: " + e.getMessage());
        }

        return list;
    }
    
    // ✅ Helper method to map ResultSet to Team object
    private Team mapTeam(ResultSet rs) throws SQLException {
        Team t = new Team();
        t.setTeamCode(rs.getString("teamCode"));
        t.setTeamName(rs.getString("teamName"));
        t.setCoachName(rs.getString("coachName"));
        t.setCaptainName(rs.getString("captainName"));
        t.setCountry(rs.getString("country"));
        t.setLogoPath(rs.getString("logoPath"));
        return t;
    }
}
