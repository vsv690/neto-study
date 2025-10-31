from fastapi import FastAPI, Request
from datetime import datetime
import mysql.connector
import os

app = FastAPI()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = int(os.getenv("DB_PORT", "3306"))
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME", "neto_ter_project_db")

def get_connection():
    return mysql.connector.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME
    )

@app.on_event("startup")
def init_db():
    """Создаёт таблицу, если её нет"""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS requests (
            id INT AUTO_INCREMENT PRIMARY KEY,
            client_ip VARCHAR(64),
            request_time DATETIME
        )
    """)
    conn.commit()
    conn.close()

@app.get("/")
async def root(request: Request):
    client_ip = request.client.host
    now = datetime.utcnow()

    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO requests (client_ip, request_time) VALUES (%s, %s)",
        (client_ip, now)
    )
    conn.commit()
    cur.close()
    conn.close()

    return {"client_ip": client_ip, "request_time": now.isoformat()}

@app.get("/all")
async def get_all():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT client_ip, request_time FROM requests ORDER BY id DESC LIMIT 10")
    rows = cur.fetchall()
    conn.close()
    return [{"client_ip": r[0], "request_time": r[1].isoformat()} for r in rows]
