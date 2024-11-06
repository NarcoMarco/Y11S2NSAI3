from flask import Flask, render_template_string, request, redirect, url_for

app = Flask(__name__)

# Login page template
login_page = """
<!doctype html>
<html lang="en">
    <head><title>Login</title></head>
    <body>
        <h2>Login</h2>
        <form method="post">
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>
    </body>
</html>
"""

# Hello World page template
hello_world_page = """
<!doctype html>
<html lang="en">
    <head><title>Wow you found the flag!</title></head>
    <body>
        <h2>MARO_CTF{72cc290e5d06a99ce5f514fce64724c0}</h2>
    </body>
</html>
"""

@app.route("/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        if username == "admin" and password == "NotS3cuR3P@ssW0rd":
            return render_template_string(hello_world_page)
        else:
            return "<h3>Invalid credentials</h3>" + login_page
    return render_template_string(login_page)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
