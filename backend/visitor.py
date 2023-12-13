import json
import boto3
import os
import time

def lambda_handler(event, context):
    dynamodb = boto3.client('dynamodb')
    table_ip = os.environ['table_ip']
    table_visitor = os.environ['table_visitor']
    condition_expression = 'attribute_not_exists(visitor)'
    increment = '0'

    client_ip = event['requestContext']['http']['sourceIp']
    
    ip_response = dynamodb.get_item(
        TableName=table_ip,
        Key={
            'ip': {'S': client_ip }
    })
    
    if not 'Item' in ip_response:
        ttl = str(time.time() + (24 * 60 * 60))
        dynamodb.put_item(
            TableName = table_ip,
            Item={
            'ip': {'S': client_ip },
            'ttl': {'N': ttl } 
        })
        increment = '1'
    
    
    
    # update visitor count
    response = dynamodb.update_item(
        TableName = table_visitor,
        Key={
            'visitor': {'S': 'visitor'}
        },
        UpdateExpression='SET #count = #count + :val',
        ExpressionAttributeValues={
        ':val': {'N': increment}
        },
        ExpressionAttributeNames={
            '#count': 'count'
        },
        ReturnValues='UPDATED_NEW'
    )
    
    return response['Attributes']['count']['N']
    # return client_ip
