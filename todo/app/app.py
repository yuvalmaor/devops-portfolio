from flask import Flask, jsonify, request, render_template
from pymongo import MongoClient
import logging
import os
from datetime import datetime
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)
db_url = os.getenv('DB_URL')
# Setup MongoDB connection
metrics = PrometheusMetrics(app)
metrics.info('app_info','Application info')

client = MongoClient(db_url)  # Replace with your MongoDB connection string
db = client["todo_list"]  # Replace "todo_list" with your database name
todos_collection = db["todos"]
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')




todo_id_counter = 0

# API endpoints


@app.route('/todos/<int:todo_id>', methods=['GET'])
def get_todo(todo_id):
    todo = next((todo for todo in todos if todo["id"] == todo_id), None) 
    if todo:
        return jsonify(todo)
    else:
        return jsonify({"error": "Todo not found"}), 404

@app.route('/todo/<int:todo_id>', methods=['GET'])
def get_todo_one(todo_id):
    # todo = next((todo for todo in todos if todo["id"] == todo_id), None) 
    # if todo:
    #     return jsonify(todo)
    # else:
    #     return jsonify({"error": "Todo not found"}), 404
    todos = list(todos_collection.find({}, {"_id": 0}))  # Exclude _id field
    for todo in todos:
        if todo["todoid"]==todo_id:
            return jsonify(todo)
    return jsonify(str(todos))

@app.route('/todos/<int:todo_id>', methods=['PUT'])
def update_todo(todo_id):
    todo = next((todo for todo in todos if todo["id"] == todo_id), None)
    if not todo:
        return jsonify({"error": "Todo not found"}), 404

    if 'task' in request.json:
        todo['task'] = request.json['task']
    if 'done' in request.json:
        todo['done'] = request.json['done']
    return jsonify({"message": "Todo updated successfully", "todo": todo})

@app.route('/todos', methods=['GET'])
def get_todos():
    todos = list(todos_collection.find({}, {"_id": 0}))  # Exclude _id field
    return jsonify(todos)

@app.route('/todos', methods=['POST'])
def create_todo():
    global todo_id_counter
    data = request.json
    
    if 'task' not in data:
        return jsonify({"error": "Task field is required"}), 400
    current_datetime = datetime.now()
    formatted_datetime = current_datetime.strftime("%Y-%m-%d %H:%M:%S")
    todo = {"task": data['task'], "done": False , "todoid":todo_id_counter  ,"created" :str(formatted_datetime) }
    logging.info('insert:'+str(todo))
    todo_id_counter+=1
    result = todos_collection.insert_one(todo)
    logging.info('result:'+str(result))
    return jsonify({"message": "Todo created successfully", "todo_id": str(result.inserted_id)}), 201

@app.route('/todos/<string:task>', methods=['DELETE'])
def delete_todos(task):
    result = todos_collection.delete_many({"task": task})
    if result.deleted_count > 0:
        return jsonify({"message": "Todos deleted successfully"})
    else:
        return jsonify({"error": "Todo not found"}), 404
    
@app.route('/deletetodos/<int:todo_id>', methods=['DELETE'])
def delete_todo_by_id(todo_id):
    result = todos_collection.delete_one({"todoid": todo_id})
    i=6
    if result.deleted_count > 0:
        return jsonify({"message": "Todo deleted successfully"})
    else:
        return jsonify({"error": "Todo not found"}), 404

@app.route('/todos/<int:todo_id>', methods=['DELETE'])
def delete_todo_by_id_two(todo_id):
    result = todos_collection.delete_one({"todoid": todo_id})
    i=6
    if result.deleted_count > 0:
        return jsonify({"message": "Todo deleted successfully"})
    else:
        return jsonify({"error": "Todo not found"}), 404

@app.route('/todos', methods=['DELETE'])
def delete_all_todos():
    result = todos_collection.delete_many({})
    if result.deleted_count > 0:
        return jsonify({"message": "Todos deleted successfully"})
    else:
        return jsonify({"error": "No todos to delete"}), 404


@app.route('/', methods=['GET'])
def index():
    global todo_id_counter
    db_url = os.getenv('DB_URL')
    
    todos = list(todos_collection.find({}, {"_id": 0}))
    return render_template('index.html', todos=todos, db_url=db_url ,todo_id_counter=todo_id_counter)

@app.route('/search.html', methods=['GET'])
def search_page():
    return render_template('search.html')


if __name__ == '__main__':
    app.run(debug=True)
