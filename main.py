import datetime
import os.path
from googleapiclient.discovery import build
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google.oauth2 import service_account


# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']
SERVICE_ACCOUNT_FILE = 'credentials.json'


def main():
    """Extract Google Calendar data for use by OPA"""
    credentials = service_account.Credentials.from_service_account_file(
        SERVICE_ACCOUNT_FILE, scopes=SCOPES)

    service = build('calendar', 'v3', credentials=credentials)

    now = datetime.datetime.utcnow().isoformat() + 'Z'
    print('Getting upcoming events')
    
    # See the Google Calendar API docs for all the options here, 
    # like limiting the number of results.
    events_result = service.events().list(
        calendarId='anders@styra.com',
        timeMin=now,
        singleEvents=True,
        orderBy='startTime'
    ).execute()

    events = events_result.get('items', [])

    print(events)

    #if not events:
    #    print('No upcoming events found.')
    #for event in events:
    #    start = event['start'].get('dateTime', event['start'].get('date'))
    #    print(start, event['summary'])


if __name__ == '__main__':
    main()
