### F-001 — Default Administrative Credential

| Field | Value |
|---|---|
| Severity | [High]{.sev .sev-high} |
| Affected asset | `support.demo.invalid/admin` |
| Status | Open |

#### Description

The administrative console accepted the fictional product's documented
factory credential. The deployment process did not require the credential to
be changed before the interface became reachable from the application network.

#### Impact

An external party able to reach the console could authenticate as an
administrator, modify application settings, access support records, and create
additional privileged accounts.

#### Evidence and reproduction

The assessor opened the administrative sign-in page and authenticated with the
vendor's example factory account. The response created an administrative
session and returned the management dashboard:

```text
GET /admin/dashboard HTTP/1.1
Host: support.demo.invalid

HTTP/1.1 200 OK
X-Demo-Role: administrator
```

No data was modified during validation.

#### Remediation

Generate a unique administrator secret during deployment and prevent startup
until the factory account has been replaced. Restrict the console to a
dedicated management network, require multifactor authentication, and alert on
administrative logins from unexpected sources.
