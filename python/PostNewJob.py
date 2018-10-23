import boto3
import json
import uuid

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')

	table.put_item(
		Item {

			'jobID' : uuid.uuid4()
			'jobTitle' : event.get('jobTitle')
			'jobDescription' : event.get('jobDescription')
			'companyName' : event.get('companyName')
			'location' : event.get('location')
			'remote' : event.get('remote')
			'salary' : event.get('salary')
			'skillSet' : event.get('skillSet')
			'recruiterEmail' : event.get('recruiterEmail')
			'recruiterName' : event.get('recruiterName')
			'active' : 'Y'

		})