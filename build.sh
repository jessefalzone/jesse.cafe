if [ "$CF_PAGES_BRANCH" = "main" ]; then zola build; else zola build --base-url "$CF_PAGES_URL" --drafts; fi
pip install minify-html
minhtml --ensure-spec-compliant-unquoted-attribute-values --do-not-minify-doctype --keep-spaces-between-attributes --keep-comments --keep-html-and-head-opening-tags --minify-css --minify-js ./public/**/*.html
