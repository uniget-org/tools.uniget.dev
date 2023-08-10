ALL_TOOLS_RAW := $(shell jq --raw-output '.tools[].name' metadata.json | xargs echo)

.PHONY:
pages: \
		$(addprefix site/content/tools/,$(addsuffix .md,$(ALL_TOOLS_RAW)))

.PHONY:
site-prerequisites: \
		$(HELPER)/var/lib/uniget/manifests/hugo.json

.PHONY:
site: \
		$(HELPER)/var/lib/uniget/manifests/hugo.json \
		metadata.json \
		site-prerequisites
	@hugo --source site --minify

site/content/tools/%.md: \
		scripts/gh-pages.sh \
		$(HELPER)/var/lib/uniget/manifests/gojq.json \
		$(HELPER)/var/lib/uniget/manifests/regclient.json \
		metadata.json \
		; $(info $(M) Generating static page for $*...)
	@\
	mkdir -p site/content/tools; \
	bash scripts/gh-pages.sh "$*" >$@