import boto3
import json
import uuid
import time

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')
	parsedJson = json.loads(event['body'])

	response = table.put_item(
		Item = {

			'jobID' : int(round(time.time() * 1000)),
			'jobTitle' : parsedJson.get('jobTitle'),
			'jobDescription' : parsedJson.get('jobDescription'),
			'companyName' : parsedJson.get('companyName'),
			'location' : parsedJson.get('location'),
			'remote' : parsedJson.get('remote'),
			'salary' : parsedJson.get('salary'),
			'skillSet' : parsedJson.get('skillSet'),
			'recruiterEmail' : parsedJson.get('recruiterEmail'),
			'recruiterName' : parsedJson.get('recruiterName'),
			'active' : parsedJson.get('active')

		})
	
	return {
    'statusCode': 200,
    'body': json.dumps(parsedJson)
}