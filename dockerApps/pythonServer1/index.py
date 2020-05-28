from flask import Flask
app = Flask(__name__)
@app.route("/")
def pythonServer():
    return "python Server exposed on port 5001!"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5001"), debug=True)
