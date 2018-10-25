import boto3
import json

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')

	response = table.update_item(
		Key={
			'jobID' : int(event.get('jobID'))

		},
		UpdateExpression="set active = :r",
		ExpressionAttributeValues={
        ':r': event.get('active')
        
    }
		)

	return response