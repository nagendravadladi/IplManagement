<%@ page import="ipl.TeamDaoImp" %>
<%@ page import="ipl.Team" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String code = request.getParameter("code");
    TeamDaoImp dao = new TeamDaoImp();
    Team team = dao.getTeamByCode(code);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Update Team – IPL Admin</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
  :root {
    --bg: #1e1e1e;
    --card-bg: #292929;
    --text-color: #f0f0f0;
    --shadow-dark: #858282;
    --shadow-light: #858282;
    --glow-color: rgb(132, 17, 240); /* glowing purple */
  }

  body {
    margin: 0;
    padding: 0;
    background: var(--bg);
    font-family: 'Segoe UI', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    color: var(--text-color);
  }

  .neumorphic-card {
    position: relative;
    background: var(--card-bg);
    border-radius: 20px;
    padding: 40px;
    width: 400px;
    z-index: 1;
    box-shadow:
      10px 10px 20px var(--shadow-dark),
      -10px -10px 20px var(--shadow-light);
    overflow: hidden;
  }

  /* NEW: Animated Glow Border */
  .neumorphic-card::before {
    content: "";
    position: absolute;
    inset: 0;
    border-radius: 20px;
    padding: 2px;
    background: linear-gradient(270deg, transparent, var(--glow-color), transparent);
    background-size: 400% 400%;
    animation: border-glow 10s linear infinite;
    z-index: -1;
    mask:
      linear-gradient(#fff 0 0) content-box,
      linear-gradient(#fff 0 0);
    mask-composite: exclude;
    -webkit-mask-composite: xor;
  }

  @keyframes border-glow {
    0% { background-position: 0% 50%; }
    100% { background-position: 200% 50%; }
  }

  .form-title {
    font-size: 24px;
    margin-bottom: 20px;
    text-align: center;
    z-index: 1;
    position: relative;
  }

  label {
    font-weight: 500;
    display: block;
    margin-bottom: 6px;
    color: var(--text-color);
  }

  .input-container {
    position: relative;
    margin-bottom: 20px;
  }

  .input-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #888;
    pointer-events: none;
  }

  .neumorphic-input {
    width: 100%;
    padding: 15px 15px 15px 45px;
    border: 1px solid rgba(132, 17, 240, 0.4);
    background: var(--card-bg);
    border-radius: 10px;
    outline: none;
    font-size: 16px;
    color: var(--text-color);
    box-sizing: border-box;
    transition: 0.2s ease-in-out;
  }

  .neumorphic-input:focus {
    border-color: var(--glow-color);
    box-shadow: 0 0 8px var(--glow-color);
  }

  .readonly {
    background: #333;
    color: #888;
    pointer-events: none;
  }

  .current-img {
    width: 120px;
    border-radius: 10px;
    display: block;
    margin: 10px auto;
    box-shadow: 5px 5px 10px var(--shadow-dark), -5px -5px 10px var(--shadow-light);
  }

  .neumorphic-file {
    padding: 12px 15px 12px 45px;
    cursor: pointer;
    background: var(--card-bg);
    color: var(--text-color);
    border: 1px solid rgba(132, 17, 240, 0.4);
    border-radius: 10px;
    font-size: 16px;
    width: 100%;
    box-sizing: border-box;
  }

  .neumorphic-file:focus {
    border-color: var(--glow-color);
    box-shadow: 0 0 8px var(--glow-color);
  }

  .neumorphic-button {
    width: 100%;
    padding: 15px;
    border: none;
    background: var(--card-bg);
    color: var(--text-color);
    font-size: 18px;
    font-weight: bold;
    border-radius: 10px;
    cursor: pointer;
    box-shadow: 5px 5px 10px var(--shadow-dark), -5px -5px 10px var(--shadow-light);
    transition: all 0.2s ease-in-out;
    margin-top: 5px;
  }

  .neumorphic-button:hover {
    box-shadow: 2px 2px 5px var(--shadow-dark), -2px -2px 5px var(--shadow-light);
  }

  .neumorphic-button:active {
    box-shadow: inset 5px 5px 10px var(--shadow-dark), inset -5px -5px 10px var(--shadow-light);
  }

  ::placeholder {
    color: #aaa;
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

<a href="admindash.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back</a>

<div class="neumorphic-card">
  <h2 class="form-title"><i class="fas fa-pen-to-square"></i> Update Team: <%= team.getTeamName() %></h2>

  <form action="TeamServlet?action=update" method="post" enctype="multipart/form-data">
    <input type="hidden" name="teamCode" value="<%= team.getTeamCode() %>">

    <div class="input-container">
      <i class="fas fa-shield-alt input-icon"></i>
      <input type="text" class="neumorphic-input" name="teamName" value="<%= team.getTeamName() %>" required>
    </div>

    <div class="input-container">
      <i class="fas fa-flag input-icon"></i>
      <input type="text" class="neumorphic-input readonly" name="country" value="<%= team.getCountry() %>" readonly>
    </div>

    <div class="input-container">
      <i class="fas fa-chalkboard-teacher input-icon"></i>
      <input type="text" class="neumorphic-input" name="coachName" value="<%= team.getCoachName() %>" required>
    </div>

    <div class="input-container">
      <i class="fas fa-user-tie input-icon"></i>
      <input type="text" class="neumorphic-input" name="captainName" value="<%= team.getCaptainName() %>" required>
    </div>

    <label><i class="fas fa-eye"></i> Current Logo</label>
    <img src="<%= team.getLogoPath() %>" class="current-img" alt="Team Logo">

    <label for="teamLogo"><i class="fas fa-upload"></i> Upload New Logo (optional)</label>
    <input type="file" class="neumorphic-input neumorphic-file" name="teamLogo" accept="image/*">

    <button type="submit" class="neumorphic-button"><i class="fas fa-save"></i> Save Changes</button>
  </form>
</div>

</body>
</html>
