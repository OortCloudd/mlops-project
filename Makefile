install:
	uv pip install -r requirements.txt
lint:
	uv run pylint --disable=R,C addfunction.py
test:
	uv run python -m pytest -vv --cov=addfunction test_addfunction.py
format:
	uv run black addfunction.py test_addfunction.py
	uv run isort addfunction.py test_addfunction.py
all: format lint test