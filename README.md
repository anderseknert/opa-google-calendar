# opa-google-calendar

Example integration of OPA using Google Calendar as a datasource

## Steps to get started

* Create a GCP service account. You do not need to change any defaults.
* In your service account settings, click "Keys" and "New key". Download the credentials file.
* Store credentials file as `credentials.json` in the project directory.
* In Google Calendar, click the calendar you want to use and choose "Settings and sharing".
* From the menu to the left, click "Share with specific people". Add the service account e-mail address.
* From the menu to the left, click "Integrate calendar". Copy the Calendar ID value.
* Run `main.py` with calendar ID as the first argument. Example: `python3 main.py anders@styra.com` 

## Resources

* [Google Calendar v3 API reference](https://developers.google.com/calendar/api/v3/reference)
* [Google Calendar v3 Python API docs](https://developers.google.com/resources/api-libraries/documentation/calendar/v3/python/latest/calendar_v3.events.html)
* [Event object description](https://developers.google.com/calendar/api/v3/reference/events)
