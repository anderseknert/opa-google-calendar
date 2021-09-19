package google

now := time.now_ns()

now_s := round(now / 1000000000)

auth_token := io.jwt.encode_sign({"alg": "RS256", "typ": "JWT"}, {
	"iss": "opa-calendar@opa-lab.iam.gserviceaccount.com",
	"scope": "https://www.googleapis.com/auth/calendar.events.readonly",
	"aud": "https://oauth2.googleapis.com/token",
	"exp": now_s + 3600,
	"iat": now_s,
}, crypto.x509.parse_rsa_private_key(opa.runtime().env.SIGNING_KEY))

access_token := http.send({
	"method": "POST",
	"url": "https://oauth2.googleapis.com/token",
	"headers": {"Content-Type": "application/x-www-form-urlencoded"},
	"raw_body": sprintf("grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=%s", [auth_token]),
}).body.access_token

url := concat("", [
	"https://www.googleapis.com/calendar/v3/calendars/",
	opa.runtime().env.CALENDAR_ID,
	"/events?",
	urlquery.encode_object({
		"orderBy": "startTime",
		"singleEvents": "true",
		"timeMin": sprintf("%sT%s.000000Z", [
			sprintf("%d-%02d-%02d", time.date(now)),
			sprintf("%02d:%02d:%02d", time.clock(now)),
		]),
	}),
])

headers := {"Authorization": concat(" ", ["Bearer", access_token])}

calendar := {"events": [e | o := http.send({"method": "GET", "url": url, "headers": headers}).body.items[_]
							f := object.filter(o, ["summary", "start", "end"])
							f != {}
							e := with_timestamps(f)]}

with_timestamps(o) = object.union(o, {
	"start": {"timestamp": time.parse_rfc3339_ns(o.start.dateTime)},
	"end": {"timestamp": time.parse_rfc3339_ns(o.end.dateTime)}
})