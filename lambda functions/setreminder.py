import json
import boto3
import pytz
from datetime import datetime, timedelta
from dateutil import parser

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('reminderTable')


def lambda_handler(event, context):

    try:
        
        body = json.loads(event['body'])
        name = body['name']
        contactInfo = body['contactInfo']
        reminderText = body['reminderText']
        reminderTime = body['reminderTime']
        timeZone = body['timeZone']

        
        userTimeZone = pytz.timezone(timeZone)
        localTime = userTimeZone.localize(parser.parse(reminderTime))
        utc_time = localTime.astimezone(pytz.utc)

        ttl = int(utc_time.timestamp())  

        
        reminderId = int(datetime.now().timestamp())  

        
        response = table.put_item(
            Item={
                'name': name,
                'reminderId': reminderId,
                'contactInfo': contactInfo,
                'reminderText': reminderText,
                'reminderTime': reminderTime,
                'ttl': ttl,
                'timeZone': timeZone
            }
        )

        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Reminder created successfully',
                'reminderId': reminderId
            })
        }
    
    except Exception as e:
        
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
