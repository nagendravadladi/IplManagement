
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>🏏-IPL Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <style>
    :root {
      --bg-dark: #1a1a1a;
      --card-dark: #242424;
      --accent-orange: #ff6600;
      --accent-blue: #00aaff;
      --text-light: #f5f5f5;
      --text-muted: #bbbbbb;
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

    /* Carousel */
    .hero-carousel {
      height: 500px;
      overflow: hidden;
      position: relative;
    }

    .hero-carousel .carousel-inner,
    .hero-carousel .carousel-item {
      height: 100%;
    }

    .hero-bg {
      width: 100%;
      height: 100%;
      object-fit: cover;
      filter: grayscale(10%) brightness(0.55);
    }

    .hero-content {
      position: absolute;
      top: 50%;
      left: 10%;
      transform: translateY(-50%);
      z-index: 2;
    }

    .hero-content h1 {
      font-size: 3.5rem;
      font-weight: bold;
    }

    .hero-content p {
      font-size: 1.2rem;
      color: var(--text-muted);
    }

    .section-title {
      font-size: 2rem;
      font-weight: 700;
      color: white;
      margin: 50px 0 10px;
      text-align: center;
      position: relative;
    }

    .section-title::after {
      content: '';
      display: block;
      width: 150px;
      height: 3px;
      background-color: #28a745;
      margin: 10px auto 0;
      border-radius: 2px;
    }
    .card:hover {
      transform: translateY(-8px);
      box-shadow: 0 0 30px rgba(0, 195, 255, 0.3);
    }
    .card-custom {
      background-color: var(--card-dark);
      border-radius: 15px;
      box-shadow: var(--shadow-blue);
      transition: all 0.3s;
      height: 100%;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .card-custom .card-img-top {
      height: 200px;
      object-fit: cover;
    }

    .card-custom .card-title {
      color: #28a745;
      font-weight: bold;
    }

    .card-custom .card-text {
      color: white;
    }

    .points-card {
      background-color: var(--card-dark);
      border-radius: 15px;
      padding: 20px;
      box-shadow: var(--shadow-blue);
      margin-bottom: 20px;
      text-align: center;
      color: var(--text-light);
      transition: all 0.3s ;
    }

    .points-card img {
      width: 80px;
      margin: 10px 0;
    }
    .points-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 0 30px rgba(0, 195, 255, 0.3);
    }

    .form-circle span {
      background: #333;
      padding: 5px 12px;
      border-radius: 50%;
      margin: 2px;
      font-weight: bold;
      display: inline-block;
    }

    .form-circle span.win {
      background: green;
      color: white;
    }

    .form-circle span.loss {
      background: red;
      color: white;
    }

    .top-player {
      text-align: center;
      padding: 40px;
      background-color: #111;
      border-radius: 15px;
      margin-top: 30px;
    }

    .top-player img {
      width: 180px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 174, 255, 0.4);
    }

    .about-box {
      background-color: #1f1f1f;
      box-shadow: 0 0 25px rgba(255, 255, 255, 0.08);
      border-radius: 20px;
      padding: 40px;
    }

/* Dock Style - Modern IPL Edition */
.dock-container {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(12px);
  padding: 14px 28px;
  border-radius: 30px;
  display: flex;
  align-items: center;
  box-shadow: 0 10px 30px rgba(0, 174, 255, 0.2);
  z-index: 9999;
}

.dock-item {
  margin: 0 12px;
  text-align: center;
  transition: all 0.3s ease;
  position: relative;
}

.dock-item a {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 13px;
  color: var(--text-muted);
  text-decoration: none;
  transition: color 0.3s ease;
}

.dock-item i {
  font-size: 22px;
  margin-bottom: 3px;
  transition: transform 0.3s ease, color 0.3s ease;
}

.dock-item:hover i {
  transform: translateY(-6px) scale(1.2);
  color: var(--accent-orange);
}

.dock-item a:hover {
  color: var(--accent-orange);
}

/* Active item style */
.dock-item a.active i,
.dock-item a.active {
  color: var(--accent-orange);
  font-weight: bold;
  text-shadow: 0 0 10px rgba(255, 102, 0, 0.6);
}

footer {
  background-color: var(--card-dark);
  padding: 25px;
  color: var(--text-muted);
      margin-top: 120px;
      text-align: left;
    }
  </style>
</head>
<body>

  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <a class="navbar-brand" href="main.jsp">
        <img src="https://documents.iplt20.com/ipl/assets/images/ipl-logo-new-old.png" alt="IPL Logo"> IPL Management
      </a>
      <a href="adlogin.jsp" class="btn btn-admin ms-auto">Admin Login</a>
    </div>
  </nav>

  <div id="heroCarousel" class="carousel slide hero-carousel" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active"><img src="1.jpg" class="hero-bg" alt="..."></div>
      <div class="carousel-item"><img src="2.jpg" class="hero-bg" alt="..."></div>
      <div class="carousel-item"><img src="96.jpg" class="hero-bg" alt="..."></div>
    </div>
    <div class="hero-content">
      <h1>MS DHONI💞</h1>
      <p>“You Don’t play for the crowd, You are playing for the country.”</p>
    </div>
  </div>

  <div class="container">
    <h2 class="section-title">Most Iconic IPL Moments</h2>
    <div class="row row-cols-1 row-cols-md-4 g-4">
      <div class="col">
        <div class="card card-custom h-100">
          <img src="RCB-Win-IPL-upl.jpg" class="card-img-top" alt="RCB Win">
          <div class="card-body">
            <h5 class="card-title">RCB Won the Cup</h5>
            <p class="card-text">RCB won their maiden title in IPL 2025, defeating Punjab Kings.</p>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="card card-custom h-100">
          <img src="csk.jpeg" class="card-img-top" alt="CSK Table Bottom">
          <div class="card-body">
            <h5 class="card-title">CSK At Table Bottom</h5>
            <p class="card-text">For the first time in IPL history, CSK ended the season at the bottom.</p>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="card card-custom h-100">
          <img src="vai.jpeg" class="card-img-top" alt="Vaibhav Suryavanshi">
          <div class="card-body">
            <h5 class="card-title">Vaibhav Suryavanshi</h5>
            <p class="card-text">14-year-old Vaibhav scored a century in 38 balls – youngest ever!</p>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="card card-custom h-100">
          <img src="che.jpeg" class="card-img-top" alt="Chepauk Roar">
          <div class="card-body">
            <h5 class="card-title">Chepauk Roar</h5>
            <p class="card-text">RCB defeated CSK at Chepauk after 17 years. Massive noise!</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="container mt-5 about-box">
    <h2 class="section-title">About IPL Foundation</h2>
    <div class="row align-items-center">
      <div class="col-md-6">
        <p>The Indian Premier League (IPL) was launched in 2007 and began in April 2008. Teams like CSK, MI, RCB, and KKR created a global tournament.</p>
        <p>The IPL is now not just a cricket league — it’s an emotion that unites millions across the world.</p>
      </div>
      <div class="col-md-6 text-center">
        <img src="ipl.jpeg" width="400" class="rounded img-fluid" alt="IPL Trophy">
      </div>
    </div>
  </div>

  <div class="container mt-5">
    <h2 class="section-title">Points Table</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">
      <div class="col">
        <div class="points-card">
          <h3>1. Punjab Kings</h3>
          <img src="https://www.iplt20.com/teams/PBKS.png" alt="PBKS Logo">
          <p><strong>Points:</strong> 19 | <strong>Played:</strong> 14 | <strong>Won:</strong> 9 | <strong>NRR:</strong> 0.372</p>
          <div class="form-circle"><span class="win">W</span><span class="loss">L</span><span class="win">W</span><span class="win">W</span></div>
        </div>
      </div>
      <div class="col">
        <div class="points-card">
          <h3>2. RCB</h3>
          <img src="https://www.iplt20.com/teams/RCB.png" alt="RCB Logo">
          <p><strong>Points:</strong> 19 | <strong>Played:</strong> 14 | <strong>Won:</strong> 9 | <strong>NRR:</strong> 0.301</p>
          <div class="form-circle"><span class="loss">L</span><span class="win">W</span><span class="win">W</span></div>
        </div>
      </div>
      <div class="col">
        <div class="points-card">
          <h3>3. Gujarat Titans</h3>
          <img src="https://www.iplt20.com/teams/GT.png" alt="GT Logo">
          <p><strong>Points:</strong> 18 | <strong>Played:</strong> 14 | <strong>Won:</strong> 9 | <strong>NRR:</strong> 0.294</p>
          <div class="form-circle"><span class="loss">L</span><span class="loss">L</span><span class="win">W</span></div>
        </div>
      </div>
    </div>
  </div>

  <div class="container mt-5">
    <h2 class="section-title">Top Performer - Orange Cap</h2>
    <div class="top-player">
      <img src="sai.png" alt="Sai Sudharsan">
      <h2>Sai Sudharsan</h2>
      <p>🏏 759 Runs in IPL 2025</p>
      <p><strong>M:</strong> 15 | <strong>HS:</strong> 108* | <strong>Avg:</strong> 54.21 | <strong>4/6s:</strong> 88/21 | <strong>100s/50s:</strong> 6/11</p>
    </div>
  </div>

  <div class="dock-container">
 <div class="dock-item"><a href="main.jsp" title="Home"><i class="fa-solid fa-house"></i> Home</a></div>
    <div class="dock-item"><a href="teams.jsp" title="Teams"><i class="fa-solid fa-users"></i> Teams</a></div>
  <div class="dock-item"><a href="players.jsp"  title="Players"><i class="fa-solid fa-user"></i> Players</a></div>
  <div class="dock-item"><a href="Matches.jsp" title="Matches"><i class="fa-solid fa-chart-line"></i> Matches</a></div>
  </div>

  <footer>
    <p>© 2025 IPL Management System. All Rights Reserved.</p>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
