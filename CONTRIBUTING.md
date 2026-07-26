# Contributing

Contributions that improve portability, document quality, validation, or
accessibility are welcome.

Before opening a change:

1. Use only fictional or explicitly redistributable sample material.
2. Run `make preflight` and `make build`.
3. Inspect both generated outputs for layout regressions.
4. Do not commit `_build/`, customer data, exam content, credentials, or flags.

Keep the default installation lightweight. Features that require a database,
hosted service, or browser application should remain optional.
