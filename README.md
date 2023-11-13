# Public dbt Macros

The purpose of this repo is to store macros that can be be of use across different dbt projects within Bestseller. 
The repo is maintained by the Data & Analytics department at Bestseller. 
The repo is public, to support use in dbtCloud governed projects.


## Contributing to the repo

Contribution is done by creating a pull request towards the master branch. Please fill out the PR template thoroughly. 
Any newly added macros will require a documentation including description, use cases, arguments, and further references (if applicable). 
Be considerate when adding new macros and check beforehand, if a usable version might already exist in any of the well-known dbt packages. 
We would like to avoid package version mismatches, that's why it is recommended to not add any packages into this repo. 

Remember that this repositiory is public, so __don't ever add any business critical content to any commit !__


## Using the repo

Use of the macros in this repository is on your own risk. 

To be able to use any of these macros, add this public repository to your project's `dependencies.yml` file (or `packages.yml` file in older proejcts). 
Pin the revision to a specific commit to avoid unexpected changes. 
Remember to run `dbt deps` to load the content into your project. 
More about this on [dbtLabs' documentation](https://docs.getdbt.com/docs/build/packages#how-do-i-add-a-package-to-my-project).

```dependencies.yml
packages:
  - package: dbt-labs/dbt_utils
    version: 1.0.0 
  - package: ...
  - git: "https://github.com/BESTSELLER/dna-public-dbt-macros.git"
    # pin the revision to a commit, version or branch
    revision: xxx
```

It is recommended, to implement the macros in your own dbt project via referencing them in a local macro under the same name. 
It can then be used within the local project under a simple macro call, without the need to a long reference.

```shared_macro.sql
{% macro shared_macro(args) -%}

{{ dna_public_dbt_macros.shared_macro(args) }}

{%- endmacro %}
```
