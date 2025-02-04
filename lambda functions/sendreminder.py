import json
import boto3
import re
from botocore.exceptions import ClientError


ses_client = boto3.client("ses", region_name="ap-south-1")  

SENDER_EMAIL = "wajeehabatool2021@gmail.com"  

def lambda_handler(event, context):
    for record in event['Records']:
        if record['eventName'] == 'REMOVE':
            old_image = record['dynamodb'].get('OldImage', {})
            if old_image:
                name = old_image.get('name', {}).get('S')
                contact_info = old_image.get('contactInfo', {}).get('S')
                reminder_text = old_image.get('reminderText', {}).get('S')
                
                if name and contact_info and reminder_text:
                    if is_email(contact_info):
                        send_email(contact_info, reminder_text)
                    elif is_phone_number(contact_info):
                        send_sms(contact_info, reminder_text)
    
    return {'statusCode': 200, 'body': json.dumps('Processed successfully')}


def is_email(contact_info):
    return bool(re.match(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)", contact_info))


def is_phone_number(contact_info):
    return bool(re.match(r"^\+?[1-9]\d{1,14}$", contact_info))


def send_email(recipient_email, reminder_text):
    try:
        ses_client.send_email(
            Source=SENDER_EMAIL,
            Destination={"ToAddresses": [recipient_email]},
            Message={
                "Subject": {"Data": "Reminder Notification"},
                "Body": {"Text": {"Data": reminder_text}, "Html": {"Data": f"<html><body><h1>Reminder</h1><p>{reminder_text}</p></body></html>"}}
            }
        )
    except ClientError as e:
        print("Error sending email:", e.response["Error"]["Message"])


def send_sms(phone_number, reminder_text):
    try:
        boto3.client('sns').publish(PhoneNumber=phone_number, Message=reminder_text)
    except Exception as e:
        print(f"Error sending SMS: {str(e)}")
