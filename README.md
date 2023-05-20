# drone-poetry

Drone plugin for running poetry commands on CI.

This plugin attempts to enable you to run arbitrary poetry commands
within a container that has recent versions of poetry and Python
installed. It also supports common poetry tasks for use in CI such as
publishing your poetry project to PyPI or a private Python package
repository simple with controlled parameterization.


## Usage

Basic, run an arbitrary poetry command:

```yaml
steps:
- name: poetry
  image: carsongee/drone-poetry
  settings:
    command: add click
```

Run a series of poetry commands:

```yaml
steps:
- name: poetry
  image: carsongee/drone-poetry
  settings:
    commands:
      - check
      - build
      - publish
```

Publish to specific repository using username, password, repository
url, and/or specified repo.

```yaml
steps:
- name: poetry
  image: carsongee/drone-poetry
  settings:
    publish:
      username: jan
      password: secret
      repository_url: https://my-private-pypi.example.com/pypi
```

or used a name repository within your poetry config
([docs](https://python-poetry.org/docs/repositories/#publishing-to-a-private-repository)):

```diff
steps:
  - name: poetry
    image: carsongee/drone-poetry
    settings:
      publish:
        username: jan
        password: secret
-       repository_url: https://my-private-pypi.example.com/pypi
+       repository: my-private
```

These options are _not_ mutually exclusive. The plugin will run all
commands and publish in sequence if all are specified. The specified
order is command, then commands, then publish.


# Parameter Reference

command
: Full arbitrary poetry command such as `add click` or `build`

commands
: Run a series of poetry commands

publish
: If set, runs `poetry publish --build...` and allows you to configure
a specific repo and credentials. Takes three optional arguments:

username: Username for the repo to publish
password: password to the repo to publish
repository: Named poetry repository to publish
repository_url: Direct URL to the repository to publish. It will create and
  delete a temp named repo in your poetry config.


## Local Usage

Without Docker:

`drone_poetry`

With Docker to simulate drone:

```
docker run --rm \
  -e PLUGIN_COMMAND=check \
  -e PLUGIN_COMMANDS='build,config --list' \
  -e PLUGIN_PUBLISH='{"username": "jan", "password": "secret", "repository_url": "https://example.com/pypi"}' \
  -e PLUGIN_DRY_RUN=true \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  carsongee/drone-poetry
```
