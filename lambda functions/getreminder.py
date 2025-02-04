import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('reminderTable')

def lambda_handler(event, context):
    try:
        
        userName = event['queryStringParameters']['name']  

        
        response = table.query(
            KeyConditionExpression="#name = :userName",  
            ExpressionAttributeNames={
                "#name": "name"  
            },
            ExpressionAttributeValues={
                ":userName": userName  
            }
        )

        
        reminders = response.get('Items', [])  

        
        def decimal_to_float(item):
            for key, value in item.items():
                if isinstance(value, Decimal):
                    item[key] = float(value)  
            return item

        
        reminders = [decimal_to_float(reminder) for reminder in reminders]

        if reminders:
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'message': f"Found {len(reminders)} reminders for user {userName}",
                    'reminders': reminders
                })
            }
        else:
            return {
                'statusCode': 404,
                'body': json.dumps({
                    'message': f"No reminders found for user {userName}"
                })
            }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({
                'message': str(e)
            })
        }
