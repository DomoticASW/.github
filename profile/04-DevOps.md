# DevOps

## Doc Automation (.github repository)

We've decided to use PlantUML in order to generate diagrams for documentation purposes.
In order to keep the generated diagrams in sync with their source files we've set up two kinds of automations:

### Diagrams

#### Git hook

A [pre-commit git hook](../hooks/pre-commit) has been set up which executes the following tasks:

1. Checks if docker is installed (as it's used to run PlantUML).
1. Uses git diff to check whether some diagram have changed.
1. If so it starts a docker container of PlanUML and generate all diagrams in the diagrams folder
1. If the generation is successful it adds to the stage the newly generated diagrams.

We've also created a [setup](../setup.sh) script that should be run after cloning the repository in order to install the git hooks.

#### GitHub action

A [GitHub action](../.github/workflows/generate-diagrams.yaml) has been set up in order to safely check server-side that the diagrams generation is correct and if it's not then regenerate them.

The action runs only if something has changed in the diagram directory.

##### Reasons behind the need of this action

1. Since we rely on git hooks to generate diagrams but they're not safe as the user is not forced to install them a check on the server-side is needed to guarantee that the diagrams are generated correctly.
1. Using only this action without the git hook would cause these problems:
   - The action is run on every push (not every commit), this means that if someone pushes many commits the generated diagrams will be updated only on the last commit.
   - Relying only on the action causes the development process to slow down and also creates unnecessary commits as the user will need to push and pull every time he changes the diagrams.

#### Delivery

##### PDF generation

On every tag push a [GitHub action](../.github/workflows/generate-pdf-doc.yaml) is run which:

1. Generate a PDF from the Markdown documentation using pandoc
2. Creates a release attaching the generated PDF file

##### GitHub pages

On every push on the main branch [GitHub action](../.github/workflows/deploy-gh-pages.yaml) is run which:

1. Move all the generated diagrams into the documentation folder (.profile)
2. Update all links to those diagrams
3. Use other appropriate actions to build the GH pages (using Jekyll)
4. Deploy the GH pages

We decided to use a custom GitHub action to publish out GH pages since the "automatic" method required our doc files to reside in specific folders, but we needed those files to be inside the `.profile` folder in order to show them as our organization README.

## Client and Server

Every rule described below must be applied both to the server and the client repositories unless otherwise specified by them.

### Branching model and GitHub branch protection rules

It has been decided to adopt [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) as branching model.
Releases will be published from the main branch.

In order to build high quality software brach protection rules have been applied to the `main` and `develop` branches resulting in the following constraints:

- merging/pushing is only allowed by means of a pull request
- pull requests must pass every check (tests, lint, ecc...) before they can be merged.
- pull requests must be reviewed and approved by another team member before they can be merged.
- force pushes are disabled

Many CI workflows run only on pull requests since these cannot be skipped in the process.

### Semantic release

The semantic-release workflow automates the versioning and publishing process for the GitHub repository and NPM package.
It analyzes commit messages and it determines the appropriate version number and publishes the new release automatically, eliminating the need for manual version management.
This workflow runs automatically on pushes to the main branch.

Moreover the release of an NPM package allows to distribute the package more easily because, for example, with just the command `npm install @domoticasw/server` it is possible to install the latest version of the server package without having to specify the version number or anything else.

#### NPM token

The NPM token is an authentication key used to publish packages the NPM registry. It allows semantic-release to authenticate with NPM and push the new package version, it is stored as a GitHub Actions secret to prevent unauthorized access.

### Conventional commits

Since semantic release is being adopted it has been decided to use [commitlint](https://github.com/conventional-changelog/commitlint) in order to enforce conventional commit messages (both in the client and server repositories).

#### commitlint CI

[DomoticASW commitlint github action](https://github.com/DomoticASW/commitlint) is run in a github workflow on every pull request in order to prohibit invalid commit messages.

It works by running commitlint verifying all the commits from the pull request base up to its head.

#### commitlint git hook

Executing commitlint only on the remote means that the developer will discover that the commit messages he wrote were wrong only after pushing them, and to fix the problem he would be forced to reword the commits and push again.

To avoid this problem a pre-commit git hook have been written under the `hooks` directory both in the server and in the client. It must be installed through the `setup.sh` script which can be found in the root of both the repositories.

> **Note:**
>
> Running commitlint on the remote is kept as a safety measure since there's no way to trust the developer that he will install the git hook.

### Semantic-release and commitlint github actions

It has been decided to extract the [semantic-release workflow](https://github.com/DomoticASW/semantic-release) and the [commitlint workflow](https://github.com/DomoticASW/commitlint) into two different github actions of the organization so that they can be resued both from the server and the client.

### Serve client web app from within the server using git submodules

We used git submodules to link the client repository within the server repository.
This approach allows us to maintain a clear separation between the two repositories while still being able to serve the client from within the server.

A limitation of this method is that the submodule points to a specific commit of the client repository. As a result, updates to the client repository are not automatically reflected in the server repository and must be manually updated.

### Code formatting

We set up prettier and two npm scripts:

- `format`: formats every file in the src folder (is expected to be run by the developer)
- `format-check`: checks that every file in the src folder is correctly formatted, it is run by both:
  - a [pre-commit git hook](https://github.com/DomoticASW/server/blob/main/hooks/pre-commit) which doesn't let the developer commit unformatted code
  - a [GitHub action](https://github.com/DomoticASW/server/blob/main/.github/workflows/code-format.yaml) that is part of the checks that need to pass before merging a PR

## Server

### Building and publishing Docker image

It is useful, especially for development (we use it in our [demo](https://github.com/DomoticASW/demo/blob/main/docker-compose.yaml)), to distribute the Server (which also includes the Client) as a Docker image.
The image is built on a two stage [Dockerfile](https://github.com/DomoticASW/server/blob/main/Dockerfile) in order to reduce the image size as much as possible.

The image is built by means of a [GitHub action](https://github.com/DomoticASW/server/blob/main/.github/workflows/release.yaml) which:

1. Waits for the semantic-release job to be completed and uses a plugin output to check if a release was actually published
2. If the release was actually published it setups Docker for building a multiplaform image
3. Publishes the docker image with tags `latest` and `<release-version>`

### Renovate

We set up Renovate through the Mend.io GitHub App in order to automate our dependency updates.

Our global renovate configuration is the default one while the server has a simple [renovate.json](https://github.com/DomoticASW/server/blob/main/renovate.json) configuration file which:

- Extends the recommended configuration file
- Instructs renovate to track both the `main` and `develop` branches
- Enables automerge for every package update that is stable and non-major
- Ensures that development dependencies are updated just on develop
- Ensures that runtime dependencies are updated just on main

The last two rules aim to reduce the number of merge conflict between main and develop while still allowing the main branch to be automatically updated (mostly for security patches).

## Client

### Client CI test suite

For the client CI has been decided to just test that the code passes the lint and compiles.
Automated tests are not possible due to being just the GUI of the wep app.

### Renovate

We decided not to enable renovate on the Client as we do not have any automated UI tests and therefore we cannot trust any dependency update to be made automatically.

## Roomba

This is one of the emulated device and is conveniently packaged as a Docker image.

### Docker image definition

In order to keep the image as lean and optimized as possible it was decided to rely upon the [sbt-native-packager](https://www.scala-sbt.org/sbt-native-packager/formats/docker.html) sbt plugin which allows to automatically build a Docker image of the project.

### Publishing the Docker image

A [GitHub action](https://github.com/DomoticASW/roomba/blob/main/.github/workflows/publish-docker-image.yaml) was set up in order to build and publish the docker image after every release (which is done manually).

The action is based on the [suggested one](https://docs.docker.com/build/ci/github-actions/multi-platform) by the Docker documentation.
The main changes are:

- It also sets up Java and sbt
- It uses the sbt plugin to generate the Dockerfile
- It also adds a specific version tag to the image
- It uses another action to update the DockerHub repository description with the content of the README file

## Boolean sensor

This is one of the emulated device and is conveniently packaged as a Docker image.

### Docker image definition

The Dockerfile is based on the [template suggested](https://gleam.run/deployment/linux-server/) by the Gleam documentation.

### Publishing the Docker image

A [GitHub action](https://github.com/DomoticASW/boolean-sensor/blob/main/.github/workflows/publish-docker-image.yaml) was set up in order to build and publish the docker image after every release (which is done manually).

The action is based on the [suggested one](https://docs.docker.com/build/ci/github-actions/multi-platform) by the Docker documentation.
The main changes are:

- It also adds a specific version tag to the image
- It uses another action to update the DockerHub repository description with the content of the README file

## Music player

This is one of the emulated device and is conveniently packaged as a Docker image.

### Docker image definition

Same as described for the **Roomba**.

### Publishing the Docker image

Same as described for the **Roomba**.

## Light sensor

This is one of the emulated device and is conveniently packaged as a Docker image.

### Docker image definition

Same as described for the **Roomba**.

### Publishing the Docker image

Same as described for the **Roomba**.

## Washing machine sensor

This is one of the emulated device and is conveniently packaged as a Docker image.

### Publishing the Docker image

A [GitHub action](https://github.com/DomoticASW/washing-machine/blob/main/.github/workflows/publish-docker-image.yml) was set up in order to build and publish the docker image after every release (which is done manually).

The action is based on the [suggested one](https://docs.docker.com/build/ci/github-actions/multi-platform) by the Docker documentation.
The main changes are:

- It also adds a specific version tag to the image
- It also uses another action so that my workflow can access the repository (actions/checkout v3).

## Smart window sensor

This is one of the emulated device and is conveniently packaged as a Docker image.

### Publishing the Docker image

A [GitHub action](https://github.com/DomoticASW/window/blob/main/.github/workflows/publish-docker-image.yml) was set up in order to build and publish the docker image after every release (which is done manually).

The action is the same as the washing machine action described before.

# Other doc

- [Description](./README.md)
- [Analysis](./01-Analysis.md)
- [Design](./02-Design.md)
- [Architecture](./03-Architecture.md)
- [Implementation (next)](./05-Implementation.md)
