# Contributing to Binder

Thanks for contributing to Binder. Please read this document before opening a
pull request.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started/)
- [VS Code](https://code.visualstudio.com/) with the
  [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Dev Container Setup

Binder ships with a dev container that provides a fully configured Ruby/Rails
environment. This is the recommended way to develop locally.

1. Clone the repository:

   ```
   git clone https://github.com/sc0v/binder.git
   cd binder
   ```

2. Open in VS Code and when prompted, click **Reopen in Container** (or run
   **Dev Containers: Reopen in Container** from the command palette).

3. VS Code will run `.devcontainer/init` on the host before building the
   container. This generates `.devcontainer/.env.local` with fresh VAPID keys
   for push notifications if it doesn't already exist.

4. VS Code will then build the container and run `.devcontainer/setup`
   automatically. This will:
   - Install gem and npm dependencies
   - Generate fresh Rails credentials
   - Create and seed the database
   - Clear logs and temp files

5. Start the server:
   ```
   rails s
   ```
   The app will be available at `http://localhost:3000`.

### Developing Without a Dev Container

If you prefer to develop outside the dev container, you will need Ruby 3.4.2
and the project dependencies installed locally. Run `bin/setup` to get started.

Push notification features require VAPID keys in your environment. Generate
them once and add to your shell profile or a local env file:

```ruby
require 'openssl'
require 'base64'

key = OpenSSL::PKey::EC.generate('prime256v1')
puts "VAPID_PUBLIC_KEY=#{Base64.urlsafe_encode64(key.public_key.to_octet_string(:uncompressed), padding: false)}"
puts "VAPID_PRIVATE_KEY=#{Base64.urlsafe_encode64(key.private_key.to_s(2), padding: false)}"
```

### Credentials

The setup script generates fresh credentials on each container build, so no
`master.key` or `config/credentials.yml.enc` is needed from another developer.
Both files are gitignored. If you need to add or edit credentials:

```
bin/rails credentials:edit
```

### Database

To reset the database to the fixture state at any time:

```
bin/rails db:prepare
bin/rails db:fixtures:load
```

## Branching and Pull Requests

- Branch off `master` for all changes
- Open pull requests against `master`
- Keep pull requests focused on a single concern
- CI must pass before merging

## Commit Messages

Binder uses [Conventional Commits](https://www.conventionalcommits.org/). Each
commit message should have a type, an optional scope, and a short description:

```
type(scope): short description

* bullet explaining why, not what
* another bullet if needed
```

Common types:

| Type       | Use for                               |
| ---------- | ------------------------------------- |
| `feat`     | new feature                           |
| `fix`      | bug fix                               |
| `refactor` | restructuring with no behavior change |
| `style`    | formatting, whitespace                |
| `test`     | adding or updating tests              |
| `docs`     | documentation only                    |
| `chore`    | build process, dependencies, tooling  |

Scope is optional but encouraged when the change is localized (e.g., `feat(checkouts):`, `fix(lint):`).

## Code Style

Binder uses automated linters to enforce consistent style. See
[docs/linting.md](docs/linting.md) for a full description of the linting setup
and how to run the linters locally.

Before opening a PR, run:

```
bin/rails lint
```

This autocorrects what it can. If anything cannot be autocorrected, the command
will exit with an error and describe what needs to be fixed manually.

To check without modifying files (what CI does):

```
bin/rails lint:dryrun
```

## Tests

Run the test suite with:

```
bin/rails test
```

All new features and bug fixes should include tests.

## Deploying to Production

Binder uses a manual promotion model for production. Staging deploys automatically
on every merge to master. Production deploys are triggered by creating a GitHub
release.

### Release naming

Releases are named by year and build number: `vYYYY.N`

For example: `v2026.1` is the first production release for Carnival 2026, and `v2026.2` is the second.

### Steps

1. Verify the change looks correct on staging at https://binder-dev.springcarnival.org
2. Create a GitHub release (this also creates the git tag):
   ```
   gh release create v2026.N --title "v2026.N" --generate-notes
   ```
3. This triggers `Production: build` followed by `Production: deploy` automatically.
4. Monitor the Actions tab to confirm both jobs complete successfully.

### Rolling back

To deploy a previous release without cutting a new one, use the manual dispatch
button on the `Production: deploy` workflow in the Actions tab. Enter the release
tag (e.g. `v2026.1`) and the workflow will deploy that image.

For manual deploys from the server, copy the podman commands from
`.github/workflows/production-deploy.yml`.

### GitHub secrets

The following secrets must be set in the repository settings:

Production: `PRODUCTION_HOST`, `PRODUCTION_USERNAME`, `PRODUCTION_SSH_KEY`
Staging: `STAGING_HOST`, `STAGING_USERNAME`, `STAGING_SSH_KEY`

To generate a deploy key:
```
ssh-keygen -t ed25519 -C "binder-deploy" -f ~/.ssh/binder-deploy
```

Add the public key to `~/.ssh/authorized_keys` on the server, and store the
private key as the `PRODUCTION_SSH_KEY` or `STAGING_SSH_KEY` secret.

### Production server prerequisites

The production server requires three things that are not managed by the pipeline:

`/home/sc0v/binder-production.env`: environment variables including VAPID keys,
database credentials, and Rails secrets. Never commit this file.

`binder-private` podman volume: contains `config/private/sp-cert.pem` and
`config/private/sp-key.pem` for university SSO. Obtain these from the university
identity provider and load manually.

`binder-logs` podman volume: mounted at `/build/log` to persist Rails logs across
container restarts. Create with `podman volume create binder-logs`.
