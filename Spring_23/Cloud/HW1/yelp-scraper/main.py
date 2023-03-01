import requests
import decimal
import csv
import datetime

END_POINT = 'https://api.yelp.com/v3/businesses/search'
API_KEY = 'wc4onikcXZt1dDM-f7yiy8SgGTwJjO3Slf5LxqBfr5XAjCT09Xa2yvLnEmeUxdswNlonjQKCV76N2L3fwHE-42AyA-5zUrbDwKcaQwXKVFSBGO3hr9Pa4UC4baL6Y3Yx'
HEADERS = {'Authorization': 'bearer %s' % API_KEY}
CLIENT_ID = 'vSL-cHuPG00heg_1xzXW-w'
LIMIT = 50 


def get_data(cuisine, location, offset):

    parameters = {
        'term' : cuisine,
        'location' : location,
        'limit' : LIMIT,
        'offset' : offset,
    }

    response = requests.get(url = END_POINT, params = parameters, headers = HEADERS)
    return response

cuisines = ['Italian', 'Chinese', 'Mexican', 'Japanese', 'French', 'American']
location = 'Manhattan'

for cuisine in cuisines:
    data = {}
    file = open(cuisine+'_data.csv', 'a', encoding = 'utf-8')
    writer = csv.writer(file)
    writer.writerow(["business_id", "name", "cuisine", "address",
                 "latitude", "longitude", "number_of_reviews", "rating", "inserted_at_time_stamp"])

    for offset in range(0, 999, LIMIT):
        response = get_data(cuisine, location, offset)
        # print(response.json())
        data = response.json()['businesses']
        for d in data:
            business_id = d['id']
            name = d['name']
            address = "'" + (" ").join(d['location']['display_address']) + "'"
            latitude = decimal.Decimal(str(d['coordinates']['latitude']))
            longitude = decimal.Decimal(str(d['coordinates']['longitude']))
            number_of_reviews = d['review_count']
            rating = decimal.Decimal(str(d['rating']))
            inserted_at_time_stamp = datetime.datetime.now()

            writer.writerow([business_id, name, cuisine, address,
                            latitude, longitude, number_of_reviews, rating, inserted_at_time_stamp])
