<%@ page isErrorPage="false" %>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: #edecec;
            font-family: Arial, sans-serif;
        }

        .neumorphic-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
            background: #edecec;
            border-radius: 20px;
            box-shadow: 10px 10px 20px azure, -10px -10px 20px azure;
            width: 300px;
        }

        .neumorphic-card h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
            text-align: center;
        }

        .error-text {
            color: red;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .input-container {
            position: relative;
            width: 100%;
            margin-bottom: 20px;
        }

        .neumorphic-input {
            width: 100%;
            padding: 15px 0 15px 45px;
            border: none;
            background: #edecec;
            border-radius: 10px;
            box-shadow: inset 5px 5px 10px #c5c5c5, inset -5px -5px 10px #ffffff;
            outline: none;
            font-size: 16px;
            color: #555;
            box-sizing: border-box;
        }

        #password-input {
            padding-right: 45px;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            pointer-events: none;
        }

        .neumorphic-button {
            width: 100%;
            padding: 15px;
            border: none;
            background: #edecec;
            color: #555;
            font-size: 18px;
            font-weight: bold;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 5px 5px 10px #c5c5c5, -5px -5px 10px #ffffff;
            transition: all 0.2s ease-in-out;
        }

        .neumorphic-button:hover {
            box-shadow: 2px 2px 5px #c5c5c5, -2px -2px 5px #ffffff;
        }

        .neumorphic-button:active {
            box-shadow: inset 5px 5px 10px #c5c5c5, inset -5px -5px 10px #ffffff;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #888;
        }

        ::placeholder {
            color: #aaa;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <div class="neumorphic-card">
        <h1>Admin Login</h1>
        <% if (error != null) { %>
            <div class="error-text"><%= error %></div>
        <% } %>

        <form action="adminloginservlet" method="post" style="width: 100%;">
            <div class="input-container">
                <i class="fas fa-user input-icon"></i>
                <input name="username" class="neumorphic-input" type="text" placeholder="Username" required>
            </div>
            <div class="input-container">
                <i class="fas fa-lock input-icon"></i>
                <input id="password-input" name="password" class="neumorphic-input" type="password" placeholder="Password" required>
                <i id="toggle-password" class="fas fa-eye toggle-password"></i>
            </div>
            <button type="submit" class="neumorphic-button">Sign In</button>
        </form>
    </div>

    <script>
        const passwordInput = document.getElementById('password-input');
        const togglePassword = document.getElementById('toggle-password');

        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
    </script>
</body>
</html>
