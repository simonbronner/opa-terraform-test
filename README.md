# Open Policy Agent Terraform Example

This repo contains a basic set of rules to exercise bespoke [Open Policy Agent](https://www.openpolicyagent.org/) rules against a terraform (0.12.x) plan file.

FWIW this code is largely an excercise in learning about OPA capabilities.

## Repo Structure

- the opa directory contains the 'rego' files (OPA Policy DSL) - queries.rego contains queries over the tf plan, rules.rego contains the policies/rules
- the opa/constraints directory contains some files that provide the data which are used by rules to enforce constraints
- the opa/plan directory contains the plan file on which the policies are to be enforced

## Pre-requisites

The various scripts assume the use of docker to avoid the overhead of installing the OPA agent. Helper scripts to generate terraform plans do assume the presence of terraform, but for the purposes of these rules, a plan is committed to the repo to alleviate the need to generate plans.

## To Run

'./evalOpaPolicies.sh' will evaluate the contino.rules namesspace against the plan file found under opa/plan/

This will generate a json file containing the output of the rules defined under that namespace. The toplevel "allow" rule is an aggregation of all the other rules - so a consuming process would only need look at the value of "allow" to determine the result.

'./testOpaPolicies.sh' will start an opa repl - allowing you to interact with the 'documents' and rules - useful for development purposes.
