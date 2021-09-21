package deployment

import data.events

default allow = false

allow {
    is_someone_on_call(time.now_ns())
}

is_someone_on_call(ns) {
    event := events[_]
    event.summary == "On Call"
    event.start.timestamp < ns
    event.end.timestamp > ns
}