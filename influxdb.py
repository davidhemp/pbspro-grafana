import os

import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS

class Connector:
    def __init__(self, config):
        self.url = config["URL"]
        self.token = config["TOKEN"]
        self.organization = config["ORG"]
        self.bucket = config["BUCKET"]

    def connect(self):
        client = influxdb_client.InfluxDBClient(
            url=self.url,
            token=self.token,
            org=self.organization
        )
        return client

    def write(self, p):
        write_api = self.connect().write_api(write_options=SYNCHRONOUS)
        write_api.write(bucket=self.bucket, org=self.organization, record=p)


if __name__ == "__main__":
    conn = Connector()


