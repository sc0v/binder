
# Binder

[![Build Status](https://travis-ci.org/sc0v/binder-app.svg?branch=master)](https://travis-ci.org/sc0v/binder-app)
[![Dependency Status](https://gemnasium.com/sc0v/binder-app.svg)](https://gemnasium.com/sc0v/binder-app)
[![Security](https://hakiri.io/github/sc0v/binder-app/master.svg)](https://hakiri.io/github/sc0v/binder-app/master)
[![Coverage Status](https://img.shields.io/coveralls/sc0v/binder-app.svg)](https://coveralls.io/r/sc0v/binder-app?branch=master)
[![Code Climate](https://codeclimate.com/github/sc0v/binder-app/badges/gpa.svg)](https://codeclimate.com/github/sc0v/binder-app)

Binder is a Spring Carnival management application built for [Carnegie Mellon Spring Carnival](https://www.springcarnival.org) using [Ruby on Rails](http://rubyonrails.org/).  Binder is used by Spring Carnival Committee and booth building organizations to do things including tracking build progress, managing tool checkouts, selling building supplies, assessing fines/charges, generating reports, and supervising student shifts.

Carnegie Mellon's Spring Carnival Committee hosts two live instances of Binder:
* **Production** (https://binder.springcarnival.org) - This environment is the production environment used to manage Spring Carnival and contains real data. *Do not deploy changes to this instance without first testing in the staging instance*.
* **Staging** (https://binder-dev.springcarnival.org) - This environment is identical to the production environment but contains fake data.  This environment is used to test changes in a production-like environment before deploying them to the production instance.


## Setting up a development environment

To work on and contribute to Binder, you will need to run Binder in a local development environment.

It is highly recommended that you use a Linux environment for development, preferably in a Debian-based distribution. [Ubuntu](http://www.ubuntu.com), [Debian](https://www.debian.org/), and [Linux Mint](https://www.linuxmint.com/) are some popular Debian-based Linux distributions (the Spring Carnival Committee server that hosts Binder runs Ubuntu). The easiest way to quickly set up a Linux development environment is by using [AWS Cloud9](https://aws.amazon.com/cloud9/).

The following set up instructions are for Debian-based systems (specifically, Ubuntu). However, the general procedure is applicable for setting up Binder in any development environment, although the details of each step will likely differ.

#### 1. Clone the Binder repository

Clone the Binder repository. To do this, run the following command (you can choose any destination directory):

```
git clone https://github.com/sc0v/binder-app.git ~/binder-app
```

#### 2. Install dependencies

Binder depends on [MySQL](https://www.mysql.com/), [SQLite](https://www.sqlite.org/), and a handful of additional development packages.  To install these dependencies, run the following command:

```
sudo apt-get install mysql-server sqlite3 libldap2-dev libmysqlclient-dev libreadline-dev libsasl2-dev libsqlite3-dev libssl-dev zlib1g-dev
```

During installation of MySQL you must create a non-blank password for the MySQL "root" user. Binder reads the MySQL username and password through the environment variables `MYSQL_USERNAME` and `MYSQL_PASSWORD`, respectively. To set these environment variables, you will need to add them to your `~/.bashrc` (or other appropriate startup script).  To do this, run the following command (where `<your_mysql_password>` is replaced with the password you created):

```sh
echo 'export MYSQL_USERNAME=root' >> ~/.bashrc
echo 'export MYSQL_PASSWORD=<your_mysql_password>' >> ~/.bashrc
```

#### 3. Install Ruby

If using Cloud9, you can select a workspace with Ruby on Rails already, otherwise proceed to installing it locally on your machine.

Binder is a [Ruby on Rails](http://rubyonrails.org/) application, so running it requires an installation of [Ruby](https://www.ruby-lang.org). It is highly recommended that you use [rbenv](https://github.com/rbenv/rbenv) and [ruby-build](https://github.com/rbenv/ruby-build) to install and manage the Ruby versions installed in your development environment. To install Ruby:

1. Follow the [instructions for installing rbenv](https://github.com/rbenv/rbenv#installation).
2. Follow the [instructions for installing ruby-build](https://github.com/rbenv/ruby-build#installation). It should be installed as a rbenv plugin.
3. Install the Ruby version used by Binder (currently 2.3.0, see [Gemfile](Gemfile)) and set it as the global Ruby version. To do this, run the following command:
    
    ```
    rbenv install 2.3.0
    rbenv global 2.3.0
    ```

#### 4. Install gem dependencies

Binder depends on numerous Ruby libraries, called gems, which are managed using [RubyGems](https://rubygems.org/). To install these gem dependencies:

1. Install the [Bundler](http://bundler.io/) gem (Bundler is used to manage gem dependencies in Binder). To do this, run the following command:
    
    ```
    gem install bundler
    ```
2. Install all gem dependencies. To do this, run the following command in the Binder repository directory:
    
    ```
    bundle install
    ```

#### 5. Seed the database

The database must be seeded with data before Binder can be run.  To do this, run the following command in the Binder repository directory:

```
rake db:setup
```

<br>
To list all available rake tasks, run the following command in the Binder repository directory:

```
rake -T
```

#### 6. Run Binder

To run Binder, run the following command in the Binder repository directory:

```
rails server
```

You can then navigate to [http://localhost:3000](http://localhost:3000) to view your local instance of Binder.  For more options see the [rails server documentation](http://guides.rubyonrails.org/command_line.html#rails-server).


## Deploying Binder

[Capistrano](http://capistranorb.com/) is used to deploy Binder to the staging and production instances. Capistrano deployment updates the staging or production environment to a specified revision from the Binder repository.

***Do not deploy changes to the production instance without first testing in the staging instance***.

To deploy Binder to the staging or production instance, run the following command in the Binder repository directory (where `<environment>` is either `staging` or `production`:

```
cap <environment> deploy
```
By default, Capistrano deploys Binder from the `master` branch.  However, when testing new features or improvements we often want to deploy from a different branch. To deploy from a specified branch, run the following command (where `<branch>` is replaced with the name of the branch to deploy from, either ):
```
cap <environment> deploy branch=<branch>
```
To seed the staging or production instance, run the following command:
```
cap <environment> db:setup
```
If any of the above commands do not work, try prepending them with ```bundle exec```.
<br>
To list all available Capistrano tasks, run the following command in the Binder repository directory:
<br>
Cap tasks listed in /config/deploy.rb

```
cap -T
```

## Documentation
In order to understand the code before you develop, we've included in /docs relevant documents from prior years' work. 

The Entity Relationship Diagram is particularly useful to understand how the different tables work together.  Furthermore, you may see project report details from various years regarding what features have been added and further opportunities to explore for development.

We recommend reading through development notes in ``` git log --oneline --graph``` as well as exploring through the code for various comments.  You will notice at the top of every model and controller the fields and types for the relevant table.  Please update these comments if you adjust these fields.

It is also helpful to understand the gems the application uses in \Gemfile.  Some specifics include:

 - [CanCanCan](https://github.com/CanCanCommunity/cancancan): handles authorization
 - [Dossier](https://github.com/tma1/dossier): handles report generation
 - [CarrierWave](https://github.com/carrierwaveuploader/carrierwave): handles fille uploads
 - [SimpleForm](https://github.com/plataformatec/simple_form): handles forms

The current design of the site is accomplished through the [Bootstrap](https://getbootstrap.com/) framework, although you can find additional CSS overwrites in \app\assets\stylesheets.

We ask that you update the documentation after any major code adjustments by adding comments, utilizing git [effectively](https://www.git-tower.com/learn/git/ebook/en/command-line/appendix/best-practices), updating the ERD with ```bundle exec erd ```, and adding relevant documents to \docs.  