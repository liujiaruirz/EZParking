import json
import os
import boto3
from opensearchpy import OpenSearch, RequestsHttpConnection
from requests_aws4auth import AWS4Auth
from botocore.exceptions import ClientError
import re

REGION = 'us-east-1'
HOST = 'search-restaurants-zitsi6j5ot24slngihahgo2a5m.us-east-1.es.amazonaws.com'
INDEX = 'restaurants'
   
def pull_from_sqs():
    sqs = boto3.client('sqs')
    queue_url = "https://sqs.us-east-1.amazonaws.com/908730732990/DiningConciergeQueue"
    response = sqs.receive_message(
        QueueUrl=queue_url,
        AttributeNames=['SentTimestamp'],
        MaxNumberOfMessages=5,
        MessageAttributeNames=['All'],
        VisibilityTimeout=10,
        WaitTimeSeconds=0
        )
    return response    
    
    
def query(term):
    q = {
        'size': 5, 
        'query': {
            # 'multi_match': {
                # 'query': term
            "bool": {
                "must": {
                    "match": {
                        "cuisine": term
                    }
                }
            }
        }
    }
    client = OpenSearch(
        hosts=[{'host': HOST, 'port': 443}],
        http_auth=get_awsauth(REGION, 'es'),
        use_ssl=True,
        verify_certs=True,
        connection_class=RequestsHttpConnection
    )
    res = client.search(index=INDEX, body=q)
    # print(res)
    hits = res['hits']['hits']
    ids = []
    for hit in hits:
        # print(hit)
        ids.append(hit['_source']['business_id'])
    return ids
    

def get_restaurant(ids, table='yelp-restaurants'):
    db = boto3.resource('dynamodb')
    table = db.Table(table)
    res = []
    # print(ids)
    for id in ids:
        key = {'business_id': id}
        try:
            response = table.get_item(Key=key)
            res.append(response)
        except ClientError as e:
            print('Error', e.response['Error']['Message'])
        else:
            print(response['Item'])
    return res
    

def sendSNS(request, res):
    sns = boto3.client('sns')
    msg = json.loads(request['Messages'][0]['Body'])
    print(msg)
    # term = json.loads(request['Messages'][0]['Body'])['Cuisine'].get('interpretedValue')
    term = re.split('[:", ]', msg['Cuisine']['StringValue'])[4][1:-1]
    # print(term)
    number_of_people = re.split('[:", ]', msg['NumberOfPeople']['StringValue'])[4][1:-1]
    print(number_of_people)
    dining_date = msg['DiningDate']['StringValue']['value']['interpretedValue']
    print(dining_date)
    dining_time = re.split('[:", ]', msg['DiningTime']['StringValue'])[4][1:-1]
    print(dining_time)
    phone_number = re.split('[:", ]', msg['PhoneNumber']['StringValue'])[4][1:-1]
    print(phone_number)
    msg = "Hello! Here are my {} restaurant suggestions for {} people, for {} at {}: ".format(term, number_of_people, dining_date, dining_time)
    count = 1
    for r in res:
        name = r['Item']['name']
        address = r['Item']['address'][2:-2]
        # print(name)
        # print(address)
        msg += "{}. {}, located at {}. ".format(count, name, address)
        count += 1
    msg += "Enjoy your meal!"
    print(msg)
    return sns.publish(PhoneNumber=phone_number, Message=msg)
    

def lambda_handler(event, context):
    print('Received event: ' + json.dumps(event))
    # request = event['Records'][0]['body']
    # if isinstance(request, str):
    #     request = json.loads(request)
    request = pull_from_sqs()
    # if isinstance(request, str):
    #     request = json.loads(request)
    print(request)
    # if "Messages" in request.keys():
    #     print("hi")
    #     print(request['Messages'][0])
    ids = query('Japanese')
    res = get_restaurant(ids)
    # print(res)
    sendSNS(request, res)
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*',
        },
        # 'body': json.dumps({'results': results})
        'body': json.dumps({'results': res})
    }
    
    
def get_awsauth(region, service):
    cred = boto3.Session().get_credentials()
    return AWS4Auth(cred.access_key,
                    cred.secret_key,
                    region,
                    service,
                    session_token=cred.token)