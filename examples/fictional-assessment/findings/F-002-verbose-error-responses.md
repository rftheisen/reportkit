### F-002 — Verbose Error Responses

| Field | Value |
|---|---|
| Severity | [Medium]{.sev .sev-medium} |
| Affected asset | `support.demo.invalid/api/tickets` |
| Status | Open |

#### Description

Malformed API requests returned framework exception names, internal source
paths, and database query fragments. These details are not required by API
clients and reveal information about the server implementation.

#### Impact

The disclosure reduces the effort required to map the application and develop
targeted attacks. The observed response did not independently expose customer
records or permit command execution.

#### Evidence and reproduction

A request containing a deliberately invalid identifier produced a detailed
debug response:

```http
GET /api/tickets/not-a-number HTTP/1.1
Host: support.demo.invalid
Accept: application/json
```

The response included a stack trace and an internal component name. The sample
report omits those invented values to model evidence minimization.

#### Remediation

Return a generic client-facing error with a correlation identifier. Record
diagnostic details only in access-controlled server logs, disable production
debug mode, and add automated tests that reject stack traces and filesystem
paths in HTTP responses.
