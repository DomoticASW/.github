# Automation document

## Doc diagrams generation

We've decided to use PlantUML in order to generate diagrams for documentation purposes.
In order to keep the generated diagrams in sync with their source files we've set up two kinds of automations:

### Git hook

A [pre-commit git hook](../hooks/pre-commit) has been set up which executes the following tasks:
1. Checks if docker is installed (as it's used to run PlantUML).
1. Uses git diff to check whether some diagram have changed.
1. If so it starts a docker container of PlanUML and generate all diagrams in the diagrams folder
1. If the generation is successful it adds to the stage the newly generated diagrams.

We've also created a [setup](../setup.sh) script that should be run after cloning the repository in order to install the git hooks.

### GitHub action

A [GitHub action](../.github/workflows/generate-diagrams.yaml) has been set up in order to safely check server-side that the diagrams generation is correct and if it's not then regenerate them.

The action runs only if something has changed in the diagram directory.

#### Reasons behind the need of this action

1. Since we rely on git hooks to generate diagrams but they're not safe as the user is not forced to install them a check on the server-side is needed to guarantee that the diagrams are generated correctly.
1. Using only this action without the git hook would cause these problems:
    - The action is run on every push (not every commit), this means that if someone pushes many commits the generated diagrams will be updated only on the last commit.
    - Relying only on the action causes the development process to slow down and also creates unnecessary commits as the user will need to push and pull every time he changes the diagrams.
