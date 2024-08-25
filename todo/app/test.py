import pytest
from unittest.mock import patch, MagicMock
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

@patch('app.todos_collection')
def test_get_todos(mock_todos_collection, client):
    # Mock the find method
    mock_todos_collection.find.return_value = [{'task': 'Test task', '_id': '1'}]
    
    rv = client.get('/todos')
    assert rv.status_code == 200
    assert isinstance(rv.json, list)
    assert len(rv.json) == 1
    assert rv.json[0]['task'] == 'Test task'

@patch('app.todos_collection')
def test_create_todo(mock_todos_collection, client):
    # Mock the insert_one method
    mock_todos_collection.insert_one.return_value = MagicMock(inserted_id='1')
    
    rv = client.post('/todos', json={'task': 'Test task'})
    assert rv.status_code == 201
    assert 'todo_id' in rv.json
    assert rv.json['todo_id'] == '1'

def test_basic_assertion():
    assert 200 == 200
