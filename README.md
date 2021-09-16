# opa-google-calendar

Example integration of OPA using Google Calendar as a datasource

## Steps to get started

* Create a GCP service account. You do not need to change any defaults.
* In your service account settings, click "Keys" and "New key". Download the credentials file.
* In Google Calendar, click the calendar you want to use and choose "Settings and sharing".
* From the menu to the left, click "Share with specific people". Add the service account e-mail address.
* From the menu to the left, click "Integrate calendar". Copy the Calendar ID value.

## Resources

* [Google Calendar v3 Python API docs](https://developers.google.com/resources/api-libraries/documentation/calendar/v3/python/latest/calendar_v3.events.html)