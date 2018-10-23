import boto3
import json
import decimal
from boto3.dynamodb.conditions import Key, Attr

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')
	
	response = table.query(
	    KeyConditionExpression=Key('active').eq("Y")
	)

	return response

	#Do I need to return JSON string?