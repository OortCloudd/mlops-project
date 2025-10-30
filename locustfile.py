from locust import HttpUser, task, between, events
import json
import numpy as np

class MLUser(HttpUser):
    wait_time = between(1,3)

    @task(2)
    def health_check(self):
        self.client.get("/get")
    
    @task(7)
    def post_test(self):
        payload = {"data": np.random.rand(1, 5).tolist()}
        self.client.post("/post", json=payload)

    @events.quitting.add_listener
    def on_quit(environment, **_kwargs):
        if environment.stats.total.get_response_time_percentile(0.95) > 10000:
            print("ML FAIL: Too Slow! Above 10s!")
            environment.runner.quit = 1
