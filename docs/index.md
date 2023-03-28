# Binder

[![Build Status](https://travis-ci.org/sc0v/binder-app.svg?branch=master)](https://travis-ci.org/sc0v/binder-app)
[![Dependency Status](https://gemnasium.com/sc0v/binder-app.svg)](https://gemnasium.com/sc0v/binder-app)
[![Security](https://hakiri.io/github/sc0v/binder-app/master.svg)](https://hakiri.io/github/sc0v/binder-app/master)
[![Coverage Status](https://img.shields.io/coveralls/sc0v/binder-app.svg)](https://coveralls.io/r/sc0v/binder-app?branch=master)
[![Code Climate](https://codeclimate.com/github/sc0v/binder-app/badges/gpa.svg)](https://codeclimate.com/github/sc0v/binder-app)

Binder is a Spring Carnival management application built for [Carnegie Mellon Spring Carnival](https://www.springcarnival.org) using [Ruby on Rails](http://rubyonrails.org/). Binder is used by Spring Carnival Committee and booth building organizations to do things including tracking build progress, managing tool checkouts, selling building supplies, assessing fines/charges, and supervising student shifts.

Carnegie Mellon's Spring Carnival Committee hosts two live instances of Binder:

- **Production** (https://binder.springcarnival.org) - This environment is the production environment used to manage Spring Carnival and contains real data. _Do not deploy changes to this instance without first testing in the staging instance_.
- **Staging** (https://binder-dev.springcarnival.org) - This environment is identical to the production environment but contains fake data. This environment is used to test changes in a production-like environment before deploying them to the production instance.

## How to use Binder (for shift volunteers/others)

Go to https://binder.springcarnival.org. 

The right hand column includes:

- **Scan tools**  - This requires both the **_tools numbers_** and the **_andrewID_** of the person checking it out.
- **Notes** - Please leave a note if anything happens during your shift and you wish to inform the next shift. To create a new note press New an enter relevant information. To view more notes go to Event Log under SCC Links at the top of the page. 
- **Structural and Elcetrical Queues** - Please do not enter a organization into any queue until they have completed the task.
- **Downtime** - The maximum amount of downtime is 4 hours. If organzations go over this amount they will receive a fine.

Other important locations:
- **Charges/Fines** - To fine or file a store purchase for an organzation go to Charges under Other Links.
- **Store** - Where an orgnaziation can purachase any additional tings they need like batteries, electrical boxes, and screws.
- **Search bar** - If a tool number is serached then the you can find out if that tool is currntly check out. If an andrewID is searched the you can find out that persons wrist band color, if they can operate the scissor list, and their organzation. **_No one can be on midway during build week without a wrist band._**
- **Home/Sign Waiver** - First page. To get back to it click spring carnval logo at top left of the screen.

## Setting up a development environment

To work on and contribute to Binder, you will need to run Binder in a local development environment.

For [active binder developers](https://github.com/orgs/sc0v/teams/binder-developers) and binder admins:

1. [Create a new branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository) with a good short name about what you're developing
1. Clone your branched repository to your local machine
1. Have or install [rvm](https://rvm.io/rvm/install)\*, sqlite, npm
1. MacOS/Linux: Change into the binder directory (`cd binder`) and rvm will yip at you to install the version of ruby found in `.ruby-version` and a gemset in `.ruby-gemset`. Read the output.
1. Windows: You also need the version of ruby from `.ruby-version`
1. Run `bin/setup` _multiple times_ until it finishes successfully. It will tell you when you've finished.
1. Run `bin/rails s` and start the rails server.
1. Open a browser and go to the URL provided in the server output (usually http://localhost:3000)

\*rbenv is also fine, but adjust directions accordingly

## Things you should do regularly

1. [Sync your branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/keeping-your-pull-request-in-sync-with-the-base-branch). A lot.
1. Lint your code e.g.: `rails lint:file:app/controllers/tools_controller.rb` Linting is available for css, js, html, html.erb, rake, rb, & yml files.

## Submitting Changes

Make changes to binder by [submitting Pull Requests (PR)](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) reasonably often. The longer you go without doing it, the more difficult it is to incorporate your code back into the main branch. So if you have created a reasonable nugget, even if it is an intermediate step in a bigger project (e.g.: You made some test fixtures), make a PR. Now folks can see what you're up to, talk to you if there will be a potential upcoming conflict, etc. Don't submit broken code; test it first. Lint your code before submitting a PR.

## Deploying Binder (normal humans stop here)

[Capistrano](http://capistranorb.com/) is used to deploy Binder to the staging and production instances. Capistrano deployment updates the staging or production environment to a specified revision from the Binder repository.

**_Do not deploy changes to the production instance without first testing in the staging instance_**.

To deploy Binder to the staging or production instance, run the following command in the Binder repository directory (where `<environment>` is either `staging` or `production`:

```
cap <environment> deploy
```

By default, Capistrano deploys Binder from the `master` branch. However, when testing new features or improvements we often want to deploy from a different branch. To deploy from a specified branch, run the following command (where `<branch>` is replaced with the name of the branch to deploy from):

```
cap <environment> deploy branch=<branch>
```

<br>
To list all available Capistrano tasks, run the following command in the Binder repository directory:
<br>
Cap tasks listed in /config/deploy.rb

```
cap -T
```
