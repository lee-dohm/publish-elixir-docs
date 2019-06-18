# Publish Elixir Docs Action

A GitHub Action that publishes the documentation for an Elixir project to the `gh-pages` branch.

> **Note:** This Action has been superseded by https://github.com/lee-dohm/generate-elixir-docs and is therefore deprecated and archived.

## Use

Publish the Elixir documentation for your project on every push to the `master` branch:

```
workflow "Publish Elixir documentation on push" {
  on = "push"
  resolves = ["Publish docs"]
}

action "Only master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Publish docs" {
  needs = "Only master"
  uses = "lee-dohm/publish-elixir-docs@master"
  secrets = ["GITHUB_TOKEN"]
}
```

## License

[MIT](LICENSE.md)
