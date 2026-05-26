from flask import Flask, jsonify
from app.utils import add_numbers

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"message": "Hello from DevOps App 🚀"})

@app.route("/health")
def health():
    return jsonify({"status": "UP"})

@app.route("/add/<int:a>/<int:b>")
def add(a, b):
    result = add_numbers(a, b)
    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)