if [ "$CF_PAGES_BRANCH" = "main" ]; then zola build; else zola build --base-url "$CF_PAGES_URL" --drafts; fi
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && . "$HOME/.cargo/env" && cargo install minhtml
minhtml --ensure-spec-compliant-unquoted-attribute-values --do-not-minify-doctype --keep-spaces-between-attributes --keep-comments --keep-html-and-head-opening-tags --minify-css --minify-js ./public/**/*.html
