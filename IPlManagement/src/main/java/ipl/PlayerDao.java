package ipl;

import java.util.List;

public interface PlayerDao {
    boolean addPlayer(Player player);
    List<Player> getPlayersByTeam(String teamCode);
    Player getPlayerByJersey(int jerseyNumber, String teamCode);
    boolean updatePlayer(Player player);
    boolean deletePlayer(int jerseyNumber, String teamCode);
    List<Player> getAllPlayers();  // Optional, in case you want all players
}
