import boto3
import json
import uuid
import time

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')

	response = table.put_item(
		Item = {

			'jobID' : int(round(time.time() * 1000)),
			'jobTitle' : event.get('jobTitle'),
			'jobDescription' : event.get('jobDescription'),
			'companyName' : event.get('companyName'),
			'location' : event.get('location'),
			'remote' : event.get('remote'),
			'salary' : event.get('salary'),
			'skillSet' : event.get('skillSet'),
			'recruiterEmail' : event.get('recruiterEmail'),
			'recruiterName' : event.get('recruiterName'),
			'active' : event.get('active')

		})
	
	return response