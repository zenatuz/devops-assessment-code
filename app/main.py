import os
from flask import Flask, send_from_directory, render_template, json
from timezone import timezone

cities = ["America/New_York", "Europe/Berlin", "Asia/Tokyo"]
timezones = []

for city in cities:
    timezones.append(timezone(city))

app = Flask(__name__)


@app.route("/favicon.ico")
def favicon():
    return send_from_directory(
        os.path.join(app.root_path, "static"),
        "favicon.ico",
        mimetype="image/vnd.microsoft.icon",
    )


@app.route("/")
def index():
    return render_template(
        "index.html", len=len(cities), City=cities, Timezones=timezones
    )


@app.route("/health")
def health():
    data = {"status_code": "200"}
    response = app.response_class(
        response=json.dumps(data), status=200, mimetype="application/json"
    )
    return response
