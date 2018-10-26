import boto3
import json

def handler (event, context):

	dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
	table = dynamodb.Table('job-table')
	parsedJson = json.loads(event['body'])

	response = table.update_item(
		Key={
			'jobID' : int(parsedJson.get('jobID'))

		},
		UpdateExpression="set active = :r",
		ExpressionAttributeValues={
        ':r': parsedJson.get('active')
        
    }
		)

	return {
    'statusCode': 200,
    'body': json.dumps(response)
}