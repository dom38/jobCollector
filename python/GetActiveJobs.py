import boto3
import json
from boto3.dynamodb.conditions import Key, Attr

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')
	filter = Key('active').eq("Y")
	response = table.scan(
		FilterExpression= filter
		)

	return {
    'statusCode': 200,
    'body': json.dumps(response)
} 