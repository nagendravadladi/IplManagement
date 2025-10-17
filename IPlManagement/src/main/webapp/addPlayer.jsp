<%@ page import="java.util.List" %>
<%@ page import="ipl.Team" %>
<%@ page import="ipl.TeamDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Player – IPL Admin</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    /*
      Removed unused CSS variables as the background style changes the base theme
    */

    /* --- GLASSMORPHISM STYLING FROM SECOND EXAMPLE --- */
    body {
      /* Placeholder for a background image and blur effect */
      background: url('96.jpg') no-repeat center center fixed; /* **IMPORTANT: Replace '2.jpg' with your actual background image path** */
      background-size: cover;
      margin: 0;
      padding: 0;
      backdrop-filter: blur(4px);
      color: #f5f5f5; /* Light text for dark background */
      font-family: 'Poppins', sans-serif;
    }

    .form-container {
      max-width: 600px;
      margin: 50px auto;
      /* Glassmorphism background */
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
      color: #ffc107; /* Changed to match the yellow highlight */
      margin-bottom: 25px;
      text-shadow: 1px 1px 2px #000;
    }

    label {
      font-weight: 500;
      color: #fff; /* White text for labels */
    }

    .form-control {
      /* Transparent input fields */
      background-color: rgba(255, 255, 255, 0.15);
      border: 1px solid rgba(255, 255, 255, 0.3);
      color: #fff;
    }

    .form-control::placeholder {
      color: #eee;
    }

    .form-control:focus {
      background-color: rgba(255, 255, 255, 0.25);
      border-color: #ffc107; /* Highlight with yellow/gold accent */
      box-shadow: 0 0 5px #ffc107;
      color: #fff;
    }
    
    /* NEW: Style for the select options to ensure they are readable */
    .form-control option {
      /* Force a dark background when the dropdown opens */
      background-color: #1e1e1e; 
      color: #fff; /* Ensure the text is white against the dark background */
    }

    .input-group-text {
      /* Matching transparent input group text */
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
    
    .alert {
      font-size: 15px;
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

<a href="adminPlayers.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back</a>

<div class="container">
  <div class="form-container">
    <h2 class="form-title"><i class="fas fa-user-plus"></i> Add New Player</h2>

    <%
      String status = request.getParameter("status");
      
      // Display a single failure message for both 'error' and 'duplicate' statuses
      if ("error".equals(status) || "duplicate".equals(status)) {
    %>
      <div class="alert alert-danger text-center">❌ Failed to add player. Please check the details and try again.</div>
    <% } %>

    <form action="PlayerServlet?action=add" method="post" enctype="multipart/form-data">

      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
        <input type="number" class="form-control" name="jerseyNumber" placeholder="Jersey Number" required
               value="<%= request.getParameter("jerseyNumber") != null ? request.getParameter("jerseyNumber") : "" %>">
      </div>

      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-user"></i></span>
        <input type="text" class="form-control" name="playerName" placeholder="Player Name" required
               value="<%= request.getParameter("playerName") != null ? request.getParameter("playerName") : "" %>">
      </div>

      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-birthday-cake"></i></span>
        <input type="number" class="form-control" name="age" placeholder="Age" required
               value="<%= request.getParameter("age") != null ? request.getParameter("age") : "" %>">
      </div>

      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
        <input type="text" class="form-control" name="role" placeholder="Role (Batsman/Bowler/Allrounder/WK)" required
               value="<%= request.getParameter("role") != null ? request.getParameter("role") : "" %>">
      </div>

      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-flag"></i></span>
        <input type="text" class="form-control" name="nationality" placeholder="Nationality" required
               value="<%= request.getParameter("nationality") != null ? request.getParameter("nationality") : "" %>">
      </div>

      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-users"></i></span>
        <select class="form-control" name="teamCode" required>
          <option value="" disabled <%= request.getParameter("teamCode") == null ? "selected" : "" %>>Select Team</option>
          <%
            TeamDaoImp teamDao = new TeamDaoImp();
            List<Team> teams = teamDao.getAllTeams();
            String selectedTeam = request.getParameter("teamCode");
            for (Team t : teams) {
              String selected = t.getTeamCode().equals(selectedTeam) ? "selected" : "";
          %>
            <option value="<%= t.getTeamCode() %>" <%= selected %>><%= t.getTeamName() %> (<%= t.getTeamCode() %>)</option>
          <% } %>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label"><i class="fas fa-image"></i> Player Image</label>
        <input type="file" class="form-control" name="playerImage" accept="image/*" required>
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-success"><i class="fas fa-check-circle"></i> Add Player</button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
