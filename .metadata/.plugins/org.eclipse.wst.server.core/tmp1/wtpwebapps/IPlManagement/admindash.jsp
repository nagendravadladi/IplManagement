<%@ page import="java.util.List" %>
<%@ page import="ipl.Team" %>
<%@ page import="ipl.TeamDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard - IPL Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    :root {
      --bg-dark: #1a1a1a;
      --card-dark: #242424;
      --text-light: #f5f5f5;
      --accent-orange: #ff6600;
      --shadow-blue: 0 4px 15px rgba(0, 174, 255, 0.2);
    }

    body {
      background-color: var(--bg-dark);
      color: var(--text-light);
      font-family: 'Poppins', sans-serif;
    }

    /* Navbar */
    .navbar {
      background-color: var(--card-dark);
      padding: 10px;
      border-bottom: 1px solid #333;
    }

    .navbar .container-fluid {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 20px;
    }

    .navbar-brand {
      font-weight: bold;
      font-size: 1.8rem;
      color: white;
      font-family: 'Brush Script MT';
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .navbar-brand img {
      width: 80px;
      height: auto;
    }

    .btn-admin {
      position: absolute;
      right: 20px;
      top: 10px;
      background-color: var(--accent-orange);
      color: white;
      padding: 6px 15px;
      border-radius: 4px;
      font-weight: 600;
      align-items: center;
    }

    .nav-link {
      color: white !important;
    } 
    .navbar-brand:hover,
    .navbar-brand:focus {
      color: white !important; 
    }

    .nav-link:hover,
    .nav-link:focus {
      color: var(--accent-blue) !important;
      background: transparent !important;
    }

    /* Dock style */
    .dock-container {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin: 20px 0;
    }

    .dock-item {
      transition: transform 0.3s ease;
    }

    .dock-item:hover {
      transform: scale(1.3) translateY(-10px);
    }

    .dock-item a {
      color: var(--text-light);
      text-decoration: none;
      font-size: 1.1rem;
      font-weight: 500;
      padding: 8px 15px;
      border-radius: 8px;
      background-color: #333;
    }

    .dock-item a.active,
    .dock-item a:hover {
      background-color: var(--accent-orange);
      color: #fff;
    }

.section-title {
  text-align: center;
  font-size: 28px;
  font-weight: 600;
  margin-top: 30px;
  margin-bottom: 10px;
  position: relative;
  color: white;
}

.section-title::after {
  content: "";
  display: block;
  width: 130px;
  height: 3px;
  background-color: red;
  margin: 10px auto 0 auto;
  border-radius: 4px;
}

.search-bar {
  text-align: center;
  margin: 15px auto;
}
.search-bar input {
  width: 50%;
  padding: 10px;
  border-radius: 6px;
  background-color: #333;
  color: white;
  border: 1px solid #555;
  font-size: 14px;
}

.team-card {
  background-color: #1e1e1e;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 0 20px rgba(0, 195, 255, 0.2);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.team-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 0 30px rgba(0, 195, 255, 0.3);
}
.image-wrapper {
  position: relative;
  height: 300px; /* was 300px */
  overflow: hidden;
}

.image-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: transform 0.4s ease;
}

.image-wrapper:hover img {
  transform: scale(1.05);
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.01);
  backdrop-filter: blur(3px);
  opacity: 0;
  transition: opacity 0.4s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 15px;
}

.image-wrapper:hover .overlay {
  opacity: 1;
}

.overlay-content {
  color: #ffffff;
  font-size: 16px;
  font-weight: bold;
  text-align: center;
  line-height: 1.8;
  background-color: rgba(0, 0, 0, 0.25);
  padding: 15px;
  border-radius: 8px;
  width: 100%;
}

.overlay-content p {
  margin: 6px 0;
}

.overlay-content p strong {
  color: #00e6e6;
  font-weight: 700;
  margin-right: 8px;
}

.card-footer {
  padding: 20px;
  margin-top: auto;
  background-color: #151515;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.team-name {
  font-size: 18px;
  font-weight: 700;
  color: #28a745;
  margin: 0;
  line-height: 1.3;
}


.team-name:hover {
  font-weight: bold;
  transform: scale(1.05);
  color: #00ffff;
}

.action-icons i {
  color: white;
  margin-left: 12px;
  font-size: 18px;
  cursor: pointer;
  transition: color 0.3s, transform 0.3s;
}

.action-icons i:hover {
  color: #ff4444;
  transform: scale(1.2);
}

    /* Floating Button */
    .floating-button {
      position: fixed;
      top: 100px;
      right: 25px;
      z-index: 999;
    }

    .floating-button a {
      background-color: #28a745;
      color: white;
      padding: 12px 20px;
      border-radius: 30px;
      text-decoration: none;
      font-weight: bold;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }

    .floating-button a:hover {
      background-color: #218838;
    }
    footer {
  background-color: var(--card-dark);
  padding: 10px;
  color: #6d6969;
  margin-top: 120px;
  text-align: left;
    }
    
    .alert {
      max-width: 600px;
      margin: 10px auto;
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">
        <img src="https://documents.iplt20.com/ipl/assets/images/ipl-logo-new-old.png" alt="IPL Logo"> IPL Management
      </a>
      <a href="main.jsp" class="btn btn-admin">Logout</a>
    </div>
  </nav>

  <!-- Dock-like Nav -->
  <div class="dock-container">
    <div class="dock-item"><a href="#" class="active"><i class="fas fa-users"></i> Teams</a></div>
    <div class="dock-item"><a href="adminPlayers.jsp"><i class="fas fa-user"></i> Players</a></div>
    <div class="dock-item"><a href="adminMatches.jsp"><i class="fas fa-chart-line"></i> Matches</a></div>
    <!-- <div class="dock-item"><a href="#"><i class="fas fa-cog"></i> Settings</a></div> -->
  </div>

  <!-- Section Title -->
  <div class="section-title">Added Teams</div>
  <!-- Search Bar -->
  <%
  String status = request.getParameter("status");
  
  if ("success".equals(status)) {
%>
  <div class="alert alert-success text-center">✅ Team **added** successfully!</div>
<% } else if ("updated".equals(status)) { %>
  <div class="alert alert-success text-center">🔄 Team **updated** successfully!</div>
<% } else if ("deleted".equals(status)) { %>
  <div class="alert alert-info text-center">🗑️ Team deleted successfully!</div>
<% } else if ("updateError".equals(status)) { %>
  <div class="alert alert-danger text-center">❌ Failed to update Team.</div>
<% } else if ("addError".equals(status)) { %>
  <div class="alert alert-danger text-center">❌ Failed to add Team.</div>
<% } %>
<div class="search-bar">
  <input type="text" id="searchInput" placeholder="Search teams by names..." onkeyup="filterTeams()">
</div>
  

  <!-- Cards Grid -->
  <div class="container mt-3">
<div class="row row-cols-1 row-cols-md-3 g-4 align-items-stretch">
      <%
        TeamDaoImp dao = new TeamDaoImp();
        List<Team> teams = dao.getAllTeams();
        for (Team t : teams) {
      %>
<div class="col">
  <div class="team-card">
    <div class="image-wrapper">
      <img src="<%= t.getLogoPath() %>" alt="Team Logo">
      <div class="overlay">
        <div class="overlay-content">
          <p><strong>Coach:</strong> <%= t.getCoachName() %></p>
          <p><strong>Captain:</strong> <%= t.getCaptainName() %></p>
          <p><strong>Country:</strong> <%= t.getCountry() %></p>
        </div>
      </div>
    </div>
    <div class="card-footer">
      <h5 class="team-name"><%= t.getTeamName() %> (<%= t.getTeamCode() %>)</h5>
      <div class="action-icons">
        <a href="updateTeam.jsp?code=<%= t.getTeamCode() %>"><i class="fas fa-edit"></i></a>
        <i class="fas fa-trash" onclick="confirmDelete('<%= t.getTeamCode() %>')"></i>
      </div>
    </div>
  </div>
</div>

      <%
        }
      %>
    </div>
  </div>

  <!-- Add Team Button -->
  <div class="floating-button">
    <a href="addTeam.jsp"><i class="fas fa-plus-circle"></i> Add Team</a>
  </div>
  <footer>
    <p>© 2025 IPL Management System. All Rights Reserved.</p>
  </footer>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function confirmDelete(code) {
      if (confirm("Are you sure you want to delete this team?")) {
        window.location.href = "TeamServlet?action=delete&teamCode=" + code;
      }
    }
    function filterTeams() {
      var input = document.getElementById("searchInput").value.toLowerCase();
      var cards = document.getElementsByClassName("team-card");
      for (var i = 0; i < cards.length; i++) {
        var cardText = cards[i].innerText.toLowerCase();
        cards[i].parentElement.style.display = cardText.includes(input) ? "" : "none";
      }
    }


  </script>

</body>
</html>
