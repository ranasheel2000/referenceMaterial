from flask import Flask
app = Flask(__name__)
@app.route("/")
def pythonServer2():
    return "pythonServer2 exposed on port-5002!"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5002"), debug=True)
