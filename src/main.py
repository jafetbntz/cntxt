import json
from flask import abort
from flask import Flask
from sqlalchemy import create_engine
from sqlalchemy.sql import text
import redis

engine = create_engine("postgresql://postgres:1234@host.docker.internal:5432/cntxt")
redis_client = redis.Redis(host='redis', port=6379)



app = Flask(__name__)

@app.route("/info")
def info():
    is_connected =  None
    with engine.connect() as session:
        is_connected = not session.closed
    
    return {
        "service": "Cntxt Serviee",
        "powered_by": "Carbono 14",
        "is_connected": is_connected
    }


@app.route("/books")
def get_books():

    result = redis_client.get("books")

    if result == None:
        with engine.connect() as session:
            q = session.execute("select * from books limit 10;")
            rows = [dict(x) for x in list(q.all())]
            result= json.dumps(rows, default=str)
            redis_client.set("books", result)
    
    return result # json.loads(result)


@app.route("/books/<id>")
def get_book(id):
    book_key =  f'books:{id}'
    result = redis_client.get(book_key)

    if result == None:
        with engine.connect() as session:
            query_string = text("select * from books where id = :id;")
            q = session.execute(query_string, id=id).first()
            if q != None:
                row = dict(q)
                result= json.dumps(row, default=str)
                redis_client.set(book_key, result)

    if result == None:
        abort(404)
        
    return result

