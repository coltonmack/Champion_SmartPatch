import requests
import os
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import re

def create_headers(bearer_token):
    headers = {"Authorization": "Bearer {}".format(bearer_token)}
    return headers

def get_tweet(headers, set, bearer_token, db, emoji_pattern):
    response = requests.get(
        "https://api.twitter.com/2/tweets?ids=1309513189374205954,1308447228055433217,1305531027243315201&expansions=author_id", headers=headers, stream=True,
    )
    print(response.status_code)
    if response.status_code != 200:
        raise Exception(
            "Cannot get stream (HTTP {}): {}".format(
                response.status_code, response.text
            )
        )
    for response_line in response.iter_lines():
        if response_line:
            json_response = json.loads(response_line)
            print(json.dumps(json_response, indent=4, sort_keys=True))
            for i in json_response["data"]:
                tweet = i["text"]
                author = i["author_id"]
                username = "Colton"
                for j in json_response["includes"]["users"]:
                    if author == j["id"]:
                        username = j["username"]
                cleaned_tweet = emoji_pattern.sub(r'', tweet)
                print(cleaned_tweet)
                print(username)
                db.collection(u'Champion').document(i['id']).set(
                    {u'Tweet':cleaned_tweet,
                     u'Author':username},
                )
                
def define_emoji_cleaner():
    emoji_pattern = re.compile("["
        u"\U0001F600-\U0001F64F"  # emoticons
        u"\U0001F300-\U0001F5FF"  # symbols & pictographs
        u"\U0001F680-\U0001F6FF"  # transport & map symbols
        u"\U0001F1E0-\U0001F1FF"  # flags (iOS)
                        "]+", flags=re.UNICODE)
    return emoji_pattern
    
def main(): 
    cred = credentials.Certificate("Cert goes here")
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    emoji_pattern = define_emoji_cleaner()
    bearer_token = "Bearer_Token"
    headers = create_headers(bearer_token)
    get_tweet(headers, set, bearer_token, db, emoji_pattern)


if __name__ == "__main__":
    main()
