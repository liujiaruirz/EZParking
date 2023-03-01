"""
This sample demonstrates an implementation of the Lex Code Hook Interface
in order to serve a sample bot which manages orders for flowers.
Bot, Intent, and Slot models which are compatible with this sample can be found in the Lex Console
as part of the 'OrderFlowers' template.

For instructions on how to set up and test this bot, as well as additional samples,
visit the Lex Getting Started documentation http://docs.aws.amazon.com/lex/latest/dg/getting-started.html.
"""
import math
import dateutil.parser
import datetime
import time
import os
import logging
import boto3
import json

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
sqs = boto3.client("sqs")


""" --- Helpers to build responses which match the structure of the necessary dialog actions --- """


def get_slots(intent_request):
    # return intent_request['currentIntent']['slots']
    return intent_request['sessionState']['intent']['slots']


def send_to_sqs(event):
    data = event.get('data')
    url = "https://sqs.us-east-1.amazonaws.com/908730732990/DiningConciergeQueue"
    try:
        resp = sqs.send_message(
            QueueUrl = url, 
            MessageBody = json.dumps({
                "Location": {
                    "StringValue": str(get_slots(event)["Location"]),
                    "DataType": "String"
                },
                "Cuisine": {
                    "StringValue": str(get_slots(event)["Cuisine"]),
                    "DataType": "String"
                },
                "DiningDate" : {
                    "StringValue": get_slots(event)["DiningDate"],
                    "DataType": "String"
                },
                "DiningTime" : {
                    "StringValue": str(get_slots(event)["DiningTime"]),
                    "DataType": "String"
                },
                "NumberOfPeople" : {
                    "StringValue": str(get_slots(event)["NumberOfPeople"]),
                    "DataType": "String"
                },
                "PhoneNumber" : {
                    "StringValue": str(get_slots(event)["PhoneNumber"]),
                    "DataType": "String"
                }
            })
        )
        logger.debug("Send result: %s", resp)
        
    except Exception as e:
        raise Exception("Could not record link! %s" % e)


def elicit_slot(session_attributes, intent_name, slots, slot_to_elicit, message):
    
    session_state['dialogAction'] = {
        'type': 'ElicitSlot',
        'slotToElicit': slot_to_elicit,
    }
        
    return {
        
        'sessionState': session_state
    }


def close(session_attributes, fulfillment_state, message):
    response = {
        'sessionAttributes': session_attributes,
        'dialogAction': {
            'type': 'Close',
            'fulfillmentState': fulfillment_state,
            'message': message
        }
    }

    return response


def delegate(session_attributes, slots):
    return {
        'sessionAttributes': session_attributes,
        'dialogAction': {
            'type': 'Delegate',
            'slots': slots
        }
    }


""" --- Helper Functions --- """


def parse_int(n):
    try:
        return int(n)
    except ValueError:
        return float('nan')


def build_validation_result(is_valid, violated_slot, message_content):
    if message_content is None:
        return {
            "isValid": is_valid,
            "violatedSlot": violated_slot,
        }

    return {
        'isValid': is_valid,
        'violatedSlot': violated_slot,
        'message': {'contentType': 'PlainText', 'content': message_content}
    }


def isvalid_date(date):
    try:
        dateutil.parser.parse(date)
        return True
    except ValueError:
        return False


def get_session_attributes(intent_request):
    """
    Get session attributes from intent request
    """
    return intent_request['sessionState']['sessionAttributes'] if intent_request['sessionState']['sessionAttributes'] is not None else {}    


def validate_dining_suggestions(location, cuisine, dining_time, number_of_people, phone_number):
    location_range = ['manhattan']
    if location is not None and location.lower() not in location_range:
        return build_validation_result(False,
                                      'Location',
                                      'We do not have {}, would you like a different location?  '
                                      'Our most popular dining location is Manhattan'.format(location))

    cuisine_range = ['japanese', 'italian', 'chinese', 'mexican', 'french', 'american']
    if cuisine is not None and cuisine.lower() not in cuisine_range:
        return build_validation_result(False,
                                      'Cuisine',
                                      'We do not have {}, would you like a different cuisine?  '
                                      'Our most popular cuisine is Italian'.format(cuisine))


    # if date is not None:
    #     if not isvalid_date(date):
    #         return build_validation_result(False, 'PickupDate', 'I did not understand that, what date would you like to pick the flowers up?')
    #     elif datetime.datetime.strptime(date, '%Y-%m-%d').date() <= datetime.date.today():
    #         return build_validation_result(False, 'PickupDate', 'You can pick up the flowers from tomorrow onwards.  What day would you like to pick them up?')

    if dining_time is not None:
        if len(dining_time) != 5:
            # Not a valid time; use a prompt defined on the build-time model.
            return build_validation_result(False, 'DiningTime', None)

        hour, minute = dining_time.split(':')
        hour = parse_int(hour)
        minute = parse_int(minute)
        if math.isnan(hour) or math.isnan(minute):
            # Not a valid time; use a prompt defined on the build-time model.
            return build_validation_result(False, 'DiningTime', None)

        if hour < 0 or hour > 24:
            # Outside of business hours
            return build_validation_result(False, 'DiningTime', 'Invalid Time')
            
    if number_of_people is not None and not number_of_people.isnumeric():
        return build_validation_result(False,
                                      'NumberOfPeople',
                                      '{} is not a valid number.'.format(number_of_people))
    
    if phone_number is not None and not phone_number.isnumeric():
        return build_validation_result(False,
                                      'PhoneNumber',
                                      '{} is not a valid number.'.format(phone_number)) 

    return build_validation_result(True, None, None)


""" --- Functions that control the bot's behavior --- """

# def greeting(intent_request):
#     """
#     Performs fulfillment for greetings
#     """
#     logger.debug('event.bot.name={}'.format(intent_request))
    
#     return close(get_session_attributes(intent_request), 
#         'Fulfilled', { 
#             'contentType': 'PlainText', 
#             'content': 'Hi there, how can I help?'
#         }
#     )
    
# def thank_you(intent_request):
#     """
#     Performs fulfillment for thank you
#     """
#     logger.debug('event.bot.name={}'.format(intent_request))
    
#     return close(get_session_attributes(intent_request), 
#         'Fulfilled', { 
#             'contentType': 'PlainText', 
#             'content': 'You are welcome!'
#         }
#     )


def dining_suggestions(intent_request):
    """
    Performs dialog management and fulfillment for ordering flowers.
    Beyond fulfillment, the implementation of this intent demonstrates the use of the elicitSlot dialog action
    in slot validation and re-prompting.
    """
    print(intent_request)
    location = get_slots(intent_request)["Location"]
    cuisine = get_slots(intent_request)["Cuisine"]
    dining_time = get_slots(intent_request)["DiningTime"]
    number_of_people = get_slots(intent_request)["NumberOfPeople"]
    phone_number = get_slots(intent_request)["PhoneNumber"]
    # source = intent_request['invocationSource']
    source = intent_request["sessionState"]

    if source == 'DialogCodeHook':
        # Perform basic validation on the supplied input slots.
        # Use the elicitSlot dialog action to re-prompt for the first violation detected.
        slots = get_slots(intent_request)

        validation_result = validate_dining_suggestions(location, cuisine, dining_time, number_of_people, phone_number)
        print("here" + str(validation_result['isValid']))
        if not validation_result['isValid']:
            slots[validation_result['violatedSlot']] = None
            return elicit_slot(intent_request['sessionAttributes'],
                              intent_request['currentIntent']['name'],
                              slots,
                              validation_result['violatedSlot'],
                              validation_result['message'])

        # Pass the price of the flowers back through session attributes to be used in various prompts defined
        # on the bot model.
        else: # is valid
            response = {'sessionState': intent_request['sessionState']}
            if "proposedNextState" in intent_request:
                response['sessionState']['dialogAction'] = intent_request['proposedNextState']['dialogAction']
                
            return response
            
    output_session_attributes = {}
    if 'sessionAttributes' in intent_request:
        output_session_attributes = intent_request['sessionAttributes'] 

        # return delegate(output_session_attributes, get_slots(intent_request))
    
    
    send_to_sqs(intent_request)

    # Order the flowers, and rely on the goodbye message of the bot to define the message to the end user.
    # In a real bot, this would likely involve a call to a backend service.
    return close(output_session_attributes,
                 'Fulfilled',
                 {'contentType': 'PlainText',
                  'content': 'You’re all set. Expect my suggestions shortly! Have a good day.'})


""" --- Intents --- """


def dispatch(intent_request):
    """
    Called when the user specifies an intent for this bot.
    """

    # logger.debug('intentName={}'.format(intent_request['currentIntent']['name']))

    # intent_name = intent_request['currentIntent']['name']
    intent_name = intent_request['sessionState']['intent']['name']

    # Dispatch to your bot's intent handlers
    # if intent_name == 'GreetingIntent':
    #     return greeting(intent_request)
    # elif intent_name == 'ThankYouIntent':
    #     return thank_you(intent_request)
    # if intent_name == 'DiningSuggestionsIntent':
    return dining_suggestions(intent_request)

    raise Exception('Intent with name ' + intent_name + ' not supported')


""" --- Main handler --- """


def lambda_handler(event, context):
    """
    Route the incoming request based on intent.
    The JSON body of the request is provided in the event slot.
    """
    
    print(event)
    # By default, treat the user request as coming from the America/New_York time zone.
    os.environ['TZ'] = 'America/New_York'
    time.tzset()
    # logger.debug('event.bot.name={}'.format(event['bot']['name']))

    return dispatch(event)



