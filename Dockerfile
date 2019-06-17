FROM elixir:1.8-alpine

LABEL "com.github.actions.name"="Publish Elixir docs"
LABEL "com.github.actions.description"="Publishes documentation for the Elixir project to `gh-pages` branch."
LABEL "com.github.actions.icon"="edit"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/lee-dohm/publish-elixir-docs"
LABEL "homepage"="https://github.com/lee-dohm/publish-elixir-docs"
LABEL "maintainer"="Lee Dohm <lee-dohm@github.com>"

ENTRYPOINT ["/entrypoint.sh"]
