# GithubAction for Composer-require-checker

All credits of the application go to the original creators of [composer-require-checker]

## Usage

You can use it as a Github Action like this:

_.github/main.workflow_
```
workflow "Main" {
  on = "push"
  resolves = ["composer-require-checker"]
}

action "composer-require-checker" {
  uses = "docker://phpga/composer-require-checker-ga"
  secrets = ["GITHUB_TOKEN"]
  args = "check"
}
```

## Docker

A [Docker-Image] is built automatically

You can run it in any given directory like this:

`docker run --rm -it -w=/app -v ${PWD}:/app composer-require-checker check`

[composer-require-checker]: https://github.com/maglnet/ComposerRequireChecker
[Docker-Image]: https://cloud.docker.com/u/phpga/repository/docker/phpga/composer-require-checker-ga
