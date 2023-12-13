import json
import urllib.request
import boto3
import os

def lambda_handler(event, context):
    ssm = boto3.client('ssm')
    message = json.loads(event['Records'][0]['Sns']['Message'])
    alarm_name = message['AlarmName']
    new_state = message['NewStateValue']
    reason = message['NewStateReason']
    
    slack_message = {
    'text': f':fire: {alarm_name} state is now {new_state}: {reason} from Nesq\n'
            f'```\n{message}```'
    }
    
    webhook_url = ssm.get_parameter(Name='cloud_resume_slackwebhookurl', WithDecryption=True)
    
    headers = {"Content-type": "application/json"}
    data = json.dumps(message).encode("utf-8")  
    req = urllib.request.Request(
        webhook_url['Parameter']['Value'],
        json.dumps(slack_message).encode('utf-8'),
        headers=headers
    )
    response = urllib.request.urlopen(req)
    
    return {
        'statusCode': response.getcode(),
        'body': response.read().decode('utf-8')
    }