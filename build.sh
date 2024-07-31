if [ "$CF_PAGES_BRANCH" = "main" ]
then
  zola build
else
  zola build --base-url "$CF_PAGES_URL" --drafts
fi

html-minifier -c minify.json --input-dir ./public --output-dir ./public --file-ext html
