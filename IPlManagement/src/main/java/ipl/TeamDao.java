package ipl;
import java.util.List;

public interface TeamDao {
    boolean addTeam(Team team);
    List<Team> getAllTeams();
    Team getTeamByCode(String code);
    boolean updateTeam(Team team);
    boolean deleteTeam(String code);
}
