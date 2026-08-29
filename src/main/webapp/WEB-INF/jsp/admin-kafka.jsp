<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>BigKart Admin Kafka Test</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #10b981;
            --primary-hover: #059669;
            --bg-gradient-start: #0f172a;
            --bg-gradient-end: #064e3b;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.1);
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
        }
        body { 
            font-family: 'Inter', sans-serif; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: center; 
            height: 100vh; 
            background: linear-gradient(135deg, var(--bg-gradient-start), var(--bg-gradient-end)); 
            color: var(--text-main);
            margin: 0; 
        }
        .card { 
            background: var(--card-bg); 
            padding: 3rem; 
            border-radius: 20px; 
            border: 1px solid var(--card-border);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3); 
            text-align: center;
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
        }
        h1 { margin-bottom: 1rem; }
        p { color: var(--text-muted); margin-bottom: 2rem; }
        .increment-btn { 
            font-size: 3rem; 
            width: 100px; 
            height: 100px; 
            border-radius: 50%; 
            border: none; 
            background: var(--primary); 
            color: white; 
            cursor: pointer; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin: 0 auto;
            transition: all 0.3s ease;
            box-shadow: 0 4px 14px 0 rgba(16, 185, 129, 0.39);
        }
        .increment-btn:hover { 
            background: var(--primary-hover); 
            transform: scale(1.05);
        }
        .increment-btn:active {
            transform: scale(0.95);
        }
        .status-msg {
            margin-top: 1rem;
            color: var(--primary);
            font-size: 0.9rem;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .status-msg.show {
            opacity: 1;
        }
    </style>
    <script>
        function incrementCounter() {
            const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');
            
            const headers = {};
            if (csrfToken && csrfHeader) {
                headers[csrfHeader] = csrfToken;
            }

            fetch('/increment', { 
                method: 'POST',
                headers: headers
            })
                .then(response => {
                    if (response.ok) {
                        const statusMsg = document.getElementById('statusMsg');
                        statusMsg.innerText = "Message sent!";
                        statusMsg.classList.add('show');
                        setTimeout(() => statusMsg.classList.remove('show'), 2000);
                    } else {
                        console.error("Failed with status: " + response.status);
                    }
                })
                .catch(err => console.error("Error incrementing:", err));
        }
    </script>
</head>
<body>
    <div class="card">
        <h1>Admin Kafka Control</h1>
        <p>Send an increment message to the topic</p>
        <button class="increment-btn" onclick="incrementCounter()">+</button>
        <div id="statusMsg" class="status-msg">Message sent!</div>
    </div>
</body>
</html>
