from flask import Flask
import pyodbc
import yaml

def read_db_config():
    params = ""
    with open("db_conf.yaml", "r") as conf:
        args = yaml.load(conf, Loader=yaml.Loader)
        server = args["DB_URL"]
        database = 'test'
        username = args["DB_USER"]
        password = args["DB_PASS"]
        port = args["DB_PORT"]
        driver = '{ODBC Driver 18 for SQL Server}'

        params = f'DRIVER={driver};SERVER={server},{port};DATABASE={database};UID={username};PWD={password}'
    return params

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/live")
def hello_world2():
    try:
        params = read_db_config()
        db = pyodbc.connect(params)

        cursor = db.cursor()

        cursor.execute("SELECT * FROM INFORMATION_SCHEMA.TABLES")
        return "<p>Well Done</p>"
    except:
        return "<p>Maintainance</p>"
