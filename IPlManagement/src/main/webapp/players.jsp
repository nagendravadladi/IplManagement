<%@ page import="java.util.List" %>
<%@ page import="ipl.Player" %>
<%@ page import="ipl.PlayerDaoImp" %>
<%@ page import="ipl.Team" %>
<%@ page import="ipl.TeamDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>IPL Players</title>
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
.card {
  position: relative;
  background-color: #121212;
  color: var(--text-light);
  border-radius: 20px;
  overflow: hidden;
  height: 100%;
  box-shadow: var(--shadow-blue);
  transform-style: preserve-3d;
  transition: transform 0.5s, box-shadow 0.5s;
  cursor: pointer;
}

.card:hover {
  transform: perspective(1000px) rotateX(10deg) translateY(-5px);
  box-shadow: 0 25px 45px rgba(255, 102, 0, 0.4); /* orange glow on hover */
}


.card img {
  width: 100%;
  height: 500px;
  object-fit: cover;
  transition: opacity 0.4s ease;
}

.card:hover img {
  opacity: 0.3;
}

.card-body {
  position: absolute;
  bottom: 45px;
  width: 100%;
  background: transparent;
  padding: 20px;
  transform: translateY(50%);
  opacity: 0;
  transition: all 0.4s ease-in-out;
}

.card:hover .card-body {
  transform: translateY(0);
  opacity: 1;
}

.card-title {
  font-size: 22px;
  font-weight: 900;
  color: #FFCC00; /* Strong yellow-gold tone for contrast */
  margin: 0;
  line-height: 1.3;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  text-align: center;
}
.card-footer {
  background-color: #434040;
  padding: 10px;
  text-align: center;
  font-weight: bold;
  text-transform: uppercase;
  color: #00f7ff;
  font-size: 22px;
  letter-spacing: 1px;
  border-top: 1px solid #333;
}

.card-text {
 color: #ffffff;
  font-size: 16px;
  font-weight: bold;
  text-align: center;
  line-height: 1.8;

}

    .search-bar {
      margin: 20px auto;
      text-align: center;
    }

    .search-bar input {
      width: 50%;
      padding: 8px 12px;
      border-radius: 6px;
      background-color: #333;
      color: white;
      border: 1px solid #555;
    }

    footer {
  background-color: var(--card-dark);
  padding: 10px;
  color: #6d6969;
  margin-top: 120px;
  text-align: left;
    }

    
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="https://documents.iplt20.com/ipl/assets/images/ipl-logo-new-old.png" alt="IPL Logo">
      IPL Management
    </a>
  </div>
</nav>

<!-- Dock Navigation -->
<div class="dock-container">
  <div class="dock-item"><a href="main.jsp" title="Home"><i class="fa-solid fa-house"></i> Home</a></div>
    <div class="dock-item"><a href="teams.jsp"><i class="fas fa-users"></i> Teams</a></div>
    <div class="dock-item"><a href="#" class="active"><i class="fas fa-user"></i> Players</a></div>
    <div class="dock-item"><a href="#"><i class="fas fa-chart-line"></i> Matches</a></div>
    <!-- <div class="dock-item"><a href="#"><i class="fas fa-cog"></i> Settings</a></div> -->
 </div>
   <div class="section-title">Players:</div>
<!-- Search Bar -->
<div class="search-bar">
  <input type="text" id="searchInput" placeholder="Search players by name, jersey number, or team..." onkeyup="filterPlayers()">
</div>

<!-- Players Cards -->
<div class="container mt-3" id="playersContainer">
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <%
      PlayerDaoImp playerDao = new PlayerDaoImp();
      TeamDaoImp teamDao = new TeamDaoImp();
      List<Team> teams = teamDao.getAllTeams();
      for (Team t : teams) {
          List<Player> players = playerDao.getPlayersByTeam(t.getTeamCode());
          for (Player p : players) {
    %>
    <div class="col player-card">
      <div class="card position-relative h-100">
        <img src="<%= p.getImagePath() != null ? p.getImagePath() : "images/default-player.png" %>" class="card-img-top" alt="Player Image">
        <div class="card-body">
          <h5 class="card-title"><%= p.getPlayerName() %> (#<%= p.getJerseyNumber() %>)</h5>
          <p class="card-text"><strong>Age:</strong> <%= p.getAge() %></p>
          <p class="card-text"><strong>Role:</strong> <%= p.getRole() %></p>
          <p class="card-text"><strong>Team:</strong> <%= t.getTeamName() %> (<%= t.getTeamCode() %>)</p>
          <p class="card-text"><strong>Nationality:</strong> <%= p.getNationality() %></p>          
        </div>
                  <div class="card-footer">
  <%= p.getPlayerName().toUpperCase() %> (#<%= p.getJerseyNumber() %>)
</div>
      </div>
    </div>
    <%
          }
      }
    %>
  </div>
</div>
  <footer>
    <p>© 2025 IPL Management System. All Rights Reserved.</p>
  </footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>

  function filterPlayers() {
    var input = document.getElementById("searchInput").value.toLowerCase();
    var cards = document.getElementsByClassName("player-card");
    for (var i = 0; i < cards.length; i++) {
      var cardText = cards[i].innerText.toLowerCase();
      cards[i].style.display = cardText.includes(input) ? "" : "none";
    }
  }
</script>

</body>
</html>
