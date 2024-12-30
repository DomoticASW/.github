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
