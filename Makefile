install:
	uv pip install --system -r requirements.txt
lint:
	pylint --disable=R,C addfunction.py
test:
	python -m pytest -vv --cov=addfunction test_addfunction.py
format:
	black addfunction.py test_addfunction.py
	isort addfunction.py test_addfunction.py
load-test:
	locust -f locustfile.py \
		--headless \
		--users $(or ${USERS},10) \
		--spawn-rate $(or ${SPAWN_RATE},2) \
		--run-time $(or ${RUN_TIME},30s) \
		--host $(or ${STAGING_URL},https://httpbin.org) \
		
all: format lint test