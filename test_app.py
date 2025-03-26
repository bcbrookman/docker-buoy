from app import *
import pytest


@pytest.mark.parametrize("test, expected", [
                            ("", "de4712"),
                            ("asdfas", "89db03"),
                        ])
def test_hash_color(test, expected):
    assert hash_color(str(test).encode()) == expected

def test_root_route_get():
    response = app.test_client().get('/')
    assert response.status_code == 200

def test_root_route_post():
    response = app.test_client().post('/')
    assert response.status_code == 405

def test_static_route_get():
    exists_response = app.test_client().get('/static/bootstrap.min.css')
    assert exists_response.status_code == 200
    nonexist_response = app.test_client().get('/static/nonexistant.css')
    assert nonexist_response.status_code == 404

def test_static_route_post():
    exists_response = app.test_client().post('/static/bootstrap.min.css')
    assert exists_response.status_code == 405
    nonexist_response = app.test_client().post('/static/nonexistant.css')
    assert nonexist_response.status_code == 405

def test_sysinfo_route_get():
    response = app.test_client().get('/sysinfo')
    assert response.status_code == 200

def test_sysinfo_route_post():
    response = app.test_client().post('/sysinfo')
    assert response.status_code == 405
