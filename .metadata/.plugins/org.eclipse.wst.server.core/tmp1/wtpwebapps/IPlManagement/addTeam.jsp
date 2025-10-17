<%@ page import="java.util.List" %>
<%@ page import="ipl.TeamDaoImp" %>
<%@ page import="ipl.Team" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New Team – IPL Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: url('2.jpg') no-repeat center center fixed; /* Please ensure '2.jpg' is the correct path for your image */
      background-size: cover;
      margin: 0;
      padding: 0;
      backdrop-filter: blur(4px);
    }

    .form-container {
      max-width: 600px;
      margin: 60px auto;
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      border-radius: 15px;
      padding: 40px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
      color: #fff;
    }

    .form-title {
      margin-bottom: 25px;
      text-align: center;
      color: #ffc107;
      font-size: 28px;
      font-weight: bold;
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

    .form-control::placeholder {
      color: #eee;
    }

    .form-control:focus {
      background-color: rgba(255, 255, 255, 0.25);
      color: #fff;
    }

    .input-group-text {
      background-color: rgba(255, 255, 255, 0.2);
      border: none;
      color: #fff;
    }

    .alert {
      font-size: 15px;
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
<a href="admindash.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back</a>
<div class="container">
  <div class="form-container">
    <h2 class="form-title"><i class="fas fa-plus-circle"></i> Add New IPL Team</h2>

    <% 
      // Retrieve status and potentially the duplicate team code from the URL
      String status = request.getParameter("status");
      String teamCodeParam = request.getParameter("teamCode");
      
      // ONLY display error/duplicate messages
      if ("error".equals(status)) {
    %>
      <div class="alert alert-danger text-center">❌ Failed to add team. Please check the data and try again.</div>
    <% 
      } else if ("duplicate".equals(status)) {
    %>
      <div class="alert alert-warning text-center">⚠️ Already exists! Please Check  the details .</div>
    <% } %>

    <form action="TeamServlet?action=add" method="post" enctype="multipart/form-data">
      
      <!-- Team Code (Removed persistence) -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-code"></i></span>
        <input type="text" class="form-control" name="teamCode" placeholder="Team Code (e.g., MI, RCB)" maxlength="3" required>
      </div>

      <!-- Team Name (Removed persistence) -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-shield-alt"></i></span>
        <input type="text" class="form-control" name="teamName" placeholder="Team Name" required>
      </div>

      <!-- Country (readonly) -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-flag"></i></span>
        <input type="text" class="form-control" name="country" value="India" readonly>
      </div>

      <!-- Coach Name (Removed persistence) -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-chalkboard-teacher"></i></span>
        <input type="text" class="form-control" name="coachName" placeholder="Coach Name" required>
      </div>

      <!-- Captain Name (Removed persistence) -->
      <div class="mb-3 input-group">
        <span class="input-group-text"><i class="fas fa-user-tie"></i></span>
        <input type="text" class="form-control" name="captainName" placeholder="Captain Name" required>
      </div>

      <!-- Team Logo -->
      <div class="mb-3">
        <label class="form-label"><i class="fas fa-image"></i> Team Logo</label>
        <input type="file" class="form-control" name="teamLogo" accept="image/*" required>
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-success"><i class="fas fa-check-circle"></i> Add Team</button>
      </div>
    </form>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
