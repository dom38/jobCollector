import boto3
import json

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')

	response = table.update(
		Key={
			'JobID' : event.JobID
		},
		UpdateExpression="set active = N"
		ReturnValues="UPDATED"
		)

	return response