# Binder

[![Build Status](https://travis-ci.org/sc0v/binder-app.svg?branch=master)](https://travis-ci.org/sc0v/binder-app)
[![Coverage Status](https://img.shields.io/coveralls/sc0v/binder-app.svg)](https://coveralls.io/r/sc0v/binder-app?branch=master)
[![Code Climate](https://codeclimate.com/github/sc0v/binder-app/badges/gpa.svg)](https://codeclimate.com/github/sc0v/binder-app)

Binder is a Spring Carnival management application built for [Carnegie Mellon Spring Carnival](https://www.springcarnival.org) using [Ruby on Rails](http://rubyonrails.org/). Binder is used by Spring Carnival Committee and booth building organizations to do things including tracking build progress, managing tool and scissor lift checkouts, selling building supplies, assessing fines/charges, and supervising student shifts.

Carnegie Mellon's Spring Carnival Committee hosts two live instances of Binder:

- **Production** (https://binder.springcarnival.org) - This environment is the production environment used to manage Spring Carnival and contains real data. _Do not deploy changes to this instance without first testing in the staging instance_.
- **Staging** (https://binder-dev.springcarnival.org) - This environment is a remote version of our development environment. This environment is used to present and test changes in a publically accessible environment before deploying them to the production instance.

Check out our [Github Wiki](https://github.com/sc0v/binder/wiki) for information about how to set up a local development environment, test and submit changes. and deploy to production.
