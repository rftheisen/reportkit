PROJECT ?= examples/fictional-assessment
THEME ?= default

.PHONY: build preflight new-finding clean

build:
	./scripts/reportkit build "$(PROJECT)" --theme "$(THEME)"

preflight:
	./scripts/reportkit preflight "$(PROJECT)"

new-finding:
	@test -n "$(TITLE)" || (echo 'Usage: make new-finding TITLE="Finding title" [SEVERITY=Medium]' && exit 2)
	./scripts/reportkit new-finding "$(PROJECT)" "$(TITLE)" --severity "$(or $(SEVERITY),Medium)"

clean:
	./scripts/reportkit clean "$(PROJECT)"
