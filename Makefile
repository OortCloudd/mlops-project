install:
	uv pip install -r requirements.txt
lint:
	pylint --disable=R,C addfunction.py
test:
	python -m pytest -vv --cov=addfunction test_addfunction.py
format:
	black addfunction.py test_addfunction.py
	isort addfunction.py test_addfunction.py
all: format lint test