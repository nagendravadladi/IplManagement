<%@ page import="java.util.List" %>
<%@ page import="ipl.Team" %>
<%@ page import="ipl.TeamDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Match – IPL Admin</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    body {
      background: url('96.jpg') no-repeat center center fixed;
      background-size: cover;
      margin: 0;
      padding: 0;
      backdrop-filter: blur(4px);
      color: #f5f5f5;
      font-family: 'Poppins', sans-serif;
    }

    .form-container {
      max-width: 600px;
      margin: 50px auto;
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      border-radius: 15px;
      padding: 40px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
      color: #fff;
    }

    .form-title {
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      color: #ffc107;
      margin-bottom: 25px;
      text-shadow: 1px 1px 2px #000;
    }

    label {
      font-weight: 500;
      color: #fff;
    }

    .form-control {
      background-color: rgba(255, 255, 255, 0.15);
      border: 1px solid rgba(255, 255, 255, 0.3);
      color: #fff;
    }

    .form-control option {
      background-color: #1e1e1e;
      color: #fff;
    }

    .form-control:focus {
      background-color: rgba(255, 255, 255, 0.25);
      border-color: #ffc107;
      box-shadow: 0 0 5px #ffc107;
      color: #fff;
    }

    .input-group-text {
      background-color: rgba(255, 255, 255, 0.2);
      border: none;
      color: #fff;
    }

    .btn-success {
      background-color: #28a745;
      border: none;
    }

    .btn-success:hover {
      background-color: #218838;
    }

    .back-link {
      position: absolute;
      top: 15px;
      left: 20px;
      color: #ccc;
      font-size: 20px;
      text-decoration: none;
    }

    .back-link:hover {
      color: purple;
    }
  </style>
</head>
<body>

<a href="adminMatches.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back</a>

<div class="container">
  <div class="form-container">
    <h2 class="form-title"><i class="fas fa-calendar-plus"></i> Add New Match</h2>

    <form action="MatchServlet?action=add" method="post">
      <!-- Match ID -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
        <input type="number" class="form-control" name="matchId" placeholder="Match ID" required>
      </div>

      <!-- Team 1 -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-flag"></i></span>
        <select class="form-control" name="team1" required>
          <option value="" disabled selected>Select Team 1</option>
          <%
            TeamDaoImp dao = new TeamDaoImp();
            List<Team> teams = dao.getAllTeams();
            for (Team t : teams) {
          %>
            <option value="<%= t.getTeamCode() %>"><%= t.getTeamName() %> (<%= t.getTeamCode() %>)</option>
          <% } %>
        </select>
      </div>

      <!-- Team 2 -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-flag-checkered"></i></span>
        <select class="form-control" name="team2" required>
          <option value="" disabled selected>Select Team 2</option>
          <%
            for (Team t : teams) {
          %>
            <option value="<%= t.getTeamCode() %>"><%= t.getTeamName() %> (<%= t.getTeamCode() %>)</option>
          <% } %>
        </select>
      </div>

      <!-- Venue -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
        <input type="text" class="form-control" name="venue" placeholder="Venue" required>
      </div>

      <!-- Match Date -->
      <div class="mb-3 input-group date-time-field">
        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
        <input type="date" class="form-control" name="matchDate">
      </div>

      <!-- Match Time -->
      <div class="mb-3 input-group date-time-field">
        <span class="input-group-text"><i class="fas fa-clock"></i></span>
        <input type="time" class="form-control" name="matchTime">
      </div>

      <!-- Status -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-trophy"></i></span>
        <select class="form-control" name="status" id="statusSelect" required onchange="toggleCompletedFields()">
          <option value="upcoming">Upcoming</option>
          <option value="completed">Completed</option>
        </select>
      </div>

      <!-- Completed match fields -->
      <div id="completedFields" style="display:none;">
        <div class="mb-3 input-group">
          <span class="input-group-text"><i class="fas fa-baseball-ball"></i></span>
          <input type="text" class="form-control" name="team1Score" placeholder="Team 1 Score (e.g. 190/9)">
        </div>

        <div class="mb-3 input-group">
          <span class="input-group-text"><i class="fas fa-baseball-ball"></i></span>
          <input type="text" class="form-control" name="team2Score" placeholder="Team 2 Score (e.g. 180/7)">
        </div>

        <div class="mb-3 input-group">
          <span class="input-group-text"><i class="fas fa-award"></i></span>
          <select class="form-control" name="winnerCode">
            <option value="">-- Select Winner --</option>
            <%
              for (Team t : teams) {
            %>
              <option value="<%= t.getTeamCode() %>"><%= t.getTeamName() %> (<%= t.getTeamCode() %>)</option>
            <% } %>
          </select>
        </div>

        <div class="mb-3 input-group">
          <span class="input-group-text"><i class="fas fa-user"></i></span>
          <input type="text" class="form-control" name="playerOfMatch" placeholder="Player of the Match">
        </div>
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-success"><i class="fas fa-check-circle"></i> Add Match</button>
      </div>
    </form>
  </div>
</div>

<script>
  function toggleCompletedFields() {
    const status = document.getElementById('statusSelect').value;
    const completedFields = document.getElementById('completedFields');
    const dateFields = document.querySelectorAll('.date-time-field');

    if (status === 'completed') {
      completedFields.style.display = 'block';
      dateFields.forEach(field => field.style.display = 'none');
    } else {
      completedFields.style.display = 'none';
      dateFields.forEach(field => field.style.display = 'flex');
    }
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
