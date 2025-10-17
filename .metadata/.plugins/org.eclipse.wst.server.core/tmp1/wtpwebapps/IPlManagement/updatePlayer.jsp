<%@ page import="java.util.List" %>
<%@ page import="ipl.PlayerDaoImp" %>
<%@ page import="ipl.Player" %>
<%@ page import="ipl.TeamDaoImp" %>
<%@ page import="ipl.Team" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int jerseyNumber = Integer.parseInt(request.getParameter("jerseyNumber"));
    String teamCode = request.getParameter("teamCode");
    PlayerDaoImp dao = new PlayerDaoImp();
    Player player = dao.getPlayerByJersey(jerseyNumber, teamCode);
    
    TeamDaoImp teamDao = new TeamDaoImp();
    List<Team> teams = teamDao.getAllTeams();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Update Player – IPL Admin</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    :root {
      --bg-dark: #1a1a1a;
      --card-dark: #242424;
      --text-light: #f5f5f5;
      --accent-purple: #a855f7;
      --shadow-purple: 0 0 15px rgba(168, 85, 247, 0.3);
    }

    body {
      background-color: var(--bg-dark);
      color: var(--text-light);
      font-family: 'Poppins', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
    }

    .form-box {
      background-color: var(--card-dark);
      border-radius: 20px;
      padding: 40px 30px;
      width: 450px;
      box-shadow: var(--shadow-purple);
      position: relative;
    }

    .form-box h2 {
      text-align: center;
      margin-bottom: 25px;
      color: var(--accent-purple);
      font-weight: 600;
    }

    label {
      margin-top: 15px;
      margin-bottom: 5px;
      color: #ccc;
    }

    .form-control, select {
      background-color: #1f1f1f;
      border: 1px solid #555;
      color: #eee;
    }

    .form-control:focus {
      border-color: var(--accent-purple);
      box-shadow: 0 0 10px var(--accent-purple);
      background-color: #1f1f1f;
      color: white;
    }

    .current-img {
      display: block;
      margin: 15px auto;
      width: 130px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(255,255,255,0.2);
    }

    .btn-submit {
      margin-top: 25px;
      background-color: var(--accent-purple);
      color: white;
      border: none;
      width: 100%;
      padding: 12px;
      font-weight: bold;
      border-radius: 8px;
      transition: 0.3s ease;
    }

    .btn-submit:hover {
      background-color: #9333ea;
    }

    .back-link {
      position: absolute;
      top: 15px;
      left: 20px;
      color: #ccc;
      font-size: 16px;
      text-decoration: none;
    }

    .back-link:hover {
      color: var(--accent-purple);
    }
  </style>
</head>
<body>

  <a href="adminPlayers.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back</a>

  <div class="form-box">
    <h2><i class="fas fa-user-edit"></i> Update Player</h2>

    <form action="PlayerServlet?action=update" method="post" enctype="multipart/form-data">
      <input type="hidden" name="jerseyNumber" value="<%= player.getJerseyNumber() %>">
      <input type="hidden" name="teamCode" value="<%= player.getTeamCode() %>">

      <label>Player Name</label>
      <input type="text" name="playerName" class="form-control" required value="<%= player.getPlayerName() %>">

      <label>Age</label>
      <input type="number" name="age" class="form-control" required value="<%= player.getAge() %>">

      <label>Role</label>
      <input type="text" name="role" class="form-control" required value="<%= player.getRole() %>">

      <label>Nationality</label>
      <input type="text" name="nationality" class="form-control" required value="<%= player.getNationality() %>">

      <label>Team</label>
      <select name="teamCode" class="form-control" required>
        <% for (Team t : teams) {
             String selected = t.getTeamCode().equals(player.getTeamCode()) ? "selected" : ""; %>
          <option value="<%= t.getTeamCode() %>" <%= selected %>><%= t.getTeamName() %> (<%= t.getTeamCode() %>)</option>
        <% } %>
      </select>

      <label>Current Image</label>
      <img src="<%= player.getImagePath() %>" alt="Player Image" class="current-img">

      <label>Upload New Image (optional)</label>
      <input type="file" name="playerImage" accept="image/*" class="form-control">

      <button type="submit" class="btn btn-submit"><i class="fas fa-save"></i> Save Changes</button>
    </form>
  </div>

</body>
</html>
