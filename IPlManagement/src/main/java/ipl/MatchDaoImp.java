package ipl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchDaoImp {

    // ✅ Add Match
	public boolean addMatch(Match match) {
		String sql = "INSERT INTO matches (match_date, match_time, team1_code, team2_code, venue, status, winner_code, team1_score, team2_score) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection con = DBUtil.getConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {

		    ps.setString(1, match.getMatchDate());
		    ps.setString(2, match.getMatchTime());      // 🕒 added time
		    ps.setString(3, match.getTeam1Code());
		    ps.setString(4, match.getTeam2Code());
		    ps.setString(5, match.getVenue());
		    ps.setString(6, match.getStatus());
		    ps.setString(7, match.getWinnerCode());
		    ps.setString(8, match.getTeam1Score());     // 🏏 added scores
		    ps.setString(9, match.getTeam2Score());

		    return ps.executeUpdate() > 0;
		}
 catch (SQLException e) {
	        System.err.println("❌ Error adding match: " + e.getMessage());
	    }
	    return false;
	}


    // ✅ Update Match
	public boolean updateMatch(Match match) {
		String sql = "UPDATE matches SET match_date=?, match_time=?, team1_code=?, team2_code=?, venue=?, status=?, winner_code=?, team1_score=?, team2_score=? WHERE match_id=?";
		try (Connection con = DBUtil.getConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {

		    ps.setString(1, match.getMatchDate());
		    ps.setString(2, match.getMatchTime());      // 🕒 added time
		    ps.setString(3, match.getTeam1Code());
		    ps.setString(4, match.getTeam2Code());
		    ps.setString(5, match.getVenue());
		    ps.setString(6, match.getStatus());
		    ps.setString(7, match.getWinnerCode());
		    ps.setString(8, match.getTeam1Score());
		    ps.setString(9, match.getTeam2Score());
		    ps.setInt(10, match.getMatchId());

		    return ps.executeUpdate() > 0;
		}
 catch (SQLException e) {
	        System.err.println("❌ Error updating match: " + e.getMessage());
	    }
	    return false;
	}

    // ✅ Delete Match
    public boolean deleteMatch(int matchId) {
        String sql = "DELETE FROM matches WHERE match_id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, matchId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error deleting match: " + e.getMessage());
        }
        return false;
    }

    // ✅ Get Match By ID
    public Match getMatchById(int matchId) {
        Match match = null;
        String sql = "SELECT * FROM matches WHERE match_id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, matchId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                match = mapMatch(rs);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching match by ID: " + e.getMessage());
        }

        return match;
    }

    // ✅ Get All Matches
    public List<Match> getAllMatches() {
        List<Match> list = new ArrayList<>();
        String sql = "SELECT * FROM matches ORDER BY match_date";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapMatch(rs));
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching all matches: " + e.getMessage());
        }

        return list;
    }

    // ✅ Get Upcoming Matches
    public List<Match> getUpcomingMatches() {
        List<Match> list = new ArrayList<>();
        String sql = "SELECT * FROM matches WHERE status='Upcoming' ORDER BY match_date";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapMatch(rs));
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching upcoming matches: " + e.getMessage());
        }

        return list;
    }

    // ✅ Get Completed Matches
    public List<Match> getCompletedMatches() {
        List<Match> list = new ArrayList<>();
        String sql = "SELECT * FROM matches WHERE status='Completed' ORDER BY match_date DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapMatch(rs));
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching completed matches: " + e.getMessage());
        }

        return list;
    }

    // ✅ Mapping ResultSet to Match object
    private Match mapMatch(ResultSet rs) throws SQLException {
        Match m = new Match();
        m.setMatchId(rs.getInt("match_id"));
        m.setMatchDate(rs.getString("match_date"));
        m.setMatchTime(rs.getString("match_time")); // ✅
        m.setTeam1Code(rs.getString("team1_code"));
        m.setTeam2Code(rs.getString("team2_code"));
        m.setVenue(rs.getString("venue"));
        m.setStatus(rs.getString("status"));
        m.setWinnerCode(rs.getString("winner_code"));
        m.setTeam1Score(rs.getString("team1_score")); // ✅
        m.setTeam2Score(rs.getString("team2_score")); // ✅
        m.setPlayerOfMatch(rs.getString("player_of_match")); // ✅ optional
        return m;
    }

}
