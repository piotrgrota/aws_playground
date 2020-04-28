import boto3
import json
import datetime
import calendar
import random
import time

stream_name = 'KinesisInputData'
kinesis_client = boto3.client('kinesis', region_name='us-east-1')

users = ["jack", "david", "adam", "piotr", "henrik", "hai", "randi", "ellis"]

def generate_record(user, timestamp, transaction_value, sample_key):
  data = {}
  data['eventTime'] = timestamp
  data['userName'] = user
  data['balance'] = transaction_value

  print("Sending: " + json.dumps(data))
  kinesis_client.put_record(
          StreamName=stream_name,
          Data=json.dumps(data),
          PartitionKey=sample_key)
    

for i in range(1, 2000):
    transaction_value = random.randint(20, 400)
    now = datetime.datetime.now()
    str_now = now.isoformat()
    user = random.choice(users)
    
    generate_record(user, str_now, transaction_value, "sample_key")
