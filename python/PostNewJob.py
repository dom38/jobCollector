import boto3

import boto3
import json

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	# data = {}
	# for key, value in event.items():
	# 	data[key] = value
	# json_data = json.dumps(data)
	table = dynamodb.Table('job-table')

	table.put_item(
		Item {
		

		})