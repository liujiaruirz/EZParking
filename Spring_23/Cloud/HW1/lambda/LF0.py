import json
import boto3

# Define the client to interact with Lex
client = boto3.client('lexv2-runtime')

def lambda_handler(event, context):
    
    msg_from_user = event['messages'][0]['unstructured']['text']
    print(f"Message from frontend: {msg_from_user}")
    
    # Initiate conversation with Lex
    response = client.recognize_text(
            botId='SZ1KJPSWF8', # MODIFY HERE
            botAliasId='1TBOCP4U1Y', # MODIFY HERE
            localeId='en_US',
            sessionId='testuser',
            text=msg_from_user)
    print(response)
    msg_from_lex = response.get('messages')
    # if msg_from_lex != []:
    msg_from_lex = msg_from_lex[0].get('content')
    print(type(msg_from_lex))
    # msg_from_lex = "I’m still under development. Please come back later."
    
    if msg_from_lex:
        print(f"Message from Chatbot: {msg_from_lex}")
        print(response)
        
        resp = {
            'statusCode': 200,
            'messages': [{
                'type': 'unstructured',
                'unstructured': {
                  'text': msg_from_lex
                }
            }]
        }
        # modify resp to send back the next question Lex would ask from the user
        
        # format resp in a way that is understood by the frontend
        # HINT: refer to function insertMessage() in chat.js that you uploaded
        # to the S3 bucket
        return resp


# import json
# import datetime
# import boto3

# def lambda_handler(event, context):
#     userMessage = event["messages"][0]["unstructured"]["text"]
#     # client = boto3.client("lex-runtime")
#     client = boto3.client('lexv2-runtime')
    
#     # response = client.post_text(
#     #     botName="DiningConcierge",
#     #     botAlias="DiningConcierge",
#     #     userId="DEV0",
#     #     inputText=userMessage
#     # );
#     response = client.recognize_text(
#             botId='SZ1KJPSWF8', # MODIFY HERE
#             botAliasId='1TBOCP4U1Y', # MODIFY HERE
#             localeId='en_US',
#             sessionId='testuser',
#             text=userMessage)
    
#     UnstructuredMessage = {
#         "id" : "0",
#         "text" : response["messages"],
#         "timestamp" : str(datetime.datetime.now())
#     }
    
#     Message = {
#         "type" : "string",
#         "unstructured" : UnstructuredMessage
#     }
    
#     botResponse = {
#         "messages": [Message]
#     }
    
#     return {
#         'statusCode': 200,
#         'body': json.dumps(botResponse)
#     }