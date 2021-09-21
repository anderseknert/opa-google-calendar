package deployments_test

import data.deployments.is_someone_on_call

test_is_someone_on_call {
    is_someone_on_call(time.parse_rfc3339_ns("2022-01-01T02:00:00Z")) with data.events as [{
    	"summary": "On Call",
        "start": {"timestamp": time.parse_rfc3339_ns("2022-01-01T01:00:00Z")},
        "end": {"timestamp": time.parse_rfc3339_ns("2022-01-01T03:00:00Z")},
    }]
    
    # Within duration, but not when including margin
    not is_someone_on_call(time.parse_rfc3339_ns("2022-01-01T02:00:00Z")) with data.events as [{
    	"summary": "On Call",
        "start": {"timestamp": time.parse_rfc3339_ns("2022-01-01T01:00:00Z")},
        "end": {"timestamp": time.parse_rfc3339_ns("2022-01-01T02:15:00Z")},
    }]

    # Not within duration
    not is_someone_on_call(time.parse_rfc3339_ns("2022-01-01T02:01:00Z")) with data.events as [{
    	"summary": "On Call",
        "start": {"timestamp": time.parse_rfc3339_ns("2022-01-01T01:00:00Z")},
        "end": {"timestamp": time.parse_rfc3339_ns("2022-01-01T02:00:00Z")},
    }]
}
