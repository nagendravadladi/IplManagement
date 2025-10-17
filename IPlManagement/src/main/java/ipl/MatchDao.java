package ipl;

import java.util.List;

public interface MatchDao {
    boolean addMatch(Match match);
    boolean updateMatch(Match match);
    boolean deleteMatch(int matchId);
    Match getMatchById(int matchId);
    List<Match> getAllMatches();
    List<Match> getUpcomingMatches();
    List<Match> getCompletedMatches();
}
