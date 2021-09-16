import datetime
import os.path
import json

from googleapiclient.discovery import build
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google.oauth2 import service_account

SERVICE_ACCOUNT_FILE = "credentials.json"


def main():
    """Extract Google Calendar data for use by OPA"""
    credentials = service_account.Credentials.from_service_account_file(
        SERVICE_ACCOUNT_FILE
    )

    service = build("calendar", "v3", credentials=credentials)

    now = datetime.datetime.utcnow().isoformat() + "Z"

    # See the Google Calendar API docs for all the options here,
    # like limiting the number of results.
    events_result = (
        service.events()
        .list(
            calendarId="anders@styra.com",
            timeMin=now,
            singleEvents=True,
            orderBy="startTime",
        )
        .execute()
    )

    result = events_result.get("items", [])
    events = []
    for event in result:
        # Filter out all keys we don't care for
        events.append({key: event[key] for key in ["summary", "start", "end"]})

    print(json.dumps(events))


if __name__ == "__main__":
    # TODO: source calendar ID from args
    main()
