import requests
import os
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import re

# To set your enviornment variables in your terminal run the following line:
# export 'BEARER_TOKEN'='<your_bearer_token>'


def create_headers(bearer_token):
    headers = {"Authorization": "Bearer {}".format(bearer_token)}
    return headers


def get_rules(headers, bearer_token):
    response = requests.get(
        "https://api.twitter.com/2/tweets/search/stream/rules", headers=headers
    )
    if response.status_code != 200:
        raise Exception(
            "Cannot get rules (HTTP {}): {}".format(response.status_code, response.text)
        )
    print(json.dumps(response.json()))
    return response.json()


def delete_all_rules(headers, bearer_token, rules):
    if rules is None or "data" not in rules:
        return None

    ids = list(map(lambda rule: rule["id"], rules["data"]))
    payload = {"delete": {"ids": ids}}
    response = requests.post(
        "https://api.twitter.com/2/tweets/search/stream/rules",
        headers=headers,
        json=payload
    )
    if response.status_code != 200:
        raise Exception(
            "Cannot delete rules (HTTP {}): {}".format(
                response.status_code, response.text
            )
        )
    print(json.dumps(response.json()))


def set_rules(headers, delete, bearer_token):
    # You can adjust the rules if needed
    sample_rules = [
        {"value": "#SmartPatch", "tag": "Champion Tweet"},
    ]
    payload = {"add": sample_rules}
    response = requests.post(
        "https://api.twitter.com/2/tweets/search/stream/rules",
        headers=headers,
        json=payload,
    )
    if response.status_code != 201:
        raise Exception(
            "Cannot add rules (HTTP {}): {}".format(response.status_code, response.text)
        )
    print(json.dumps(response.json()))


def get_stream(headers, set, bearer_token,db,emoji_pattern):
    response = requests.get(
        "https://api.twitter.com/2/tweets/search/stream?expansions=author_id", headers=headers, stream=True,
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
            tweet = json_response["data"]["text"]
            author = json_response["data"]["author_id"]
            username = "Colton"
            for j in json_response["includes"]["users"]:
                if author == j["id"]:
                    username = j["username"]
            cleaned_tweet = emoji_pattern.sub(r'', tweet)
            print(cleaned_tweet)
            print(username)
            db.collection(u'SmartPatch').document(json_response["data"]['id']).set(
                {u'Tweet':cleaned_tweet,
                 u'Author':username}
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
    cred = credentials.Certificate("Cert_Location")
    firebase_admin.initialize_app(cred)
    bearer_token = "Bearer_Token"   
    headers = create_headers(bearer_token)
    rules = get_rules(headers, bearer_token)
    delete = delete_all_rules(headers, bearer_token, rules)
    set = set_rules(headers, delete, bearer_token)
    db = firestore.client()
    emoji_pattern = define_emoji_cleaner()
    get_stream(headers, set, bearer_token, db, emoji_pattern)


if __name__ == "__main__":
    main()
