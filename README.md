
## Rails Engine Lite: Turing Backend Cohort 2201 Mod 3
"Rails Engine Lite" is an individual project that requires students to build API endpoints to expose data for merchants and items, as well as to search for merchants and items using those endpoints.
- Original project and requirements can be found [here](https://backend.turing.edu/module3/projects/rails_engine_lite/)

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

## Learning goals:
- Practice building API endpoints to expose limited data.
- Utilize advanced routing techniques including namespacing to organize functionality.
- Use serializers to format JSON responses.
- Utilize ActiveRecord and some raw SQL to gather data.
- Use Postman for a test harness and to practice making API calls.

## Schema
- See image below for project database schema:

[railsengineliteschema2.pdf](https://github.com/psitosam/rails-engine/files/8734637/railsengineliteschema2.pdf)

## Requirements and Setup (for Mac):

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.8

## Gems used:

- RSpec
- Pry
- SimpleCov
- Capybara
- Shoulda-Matchers v5.0
- Factory_Bot_Rails
- Faker
- jsonapi-serializer

## Development setup:

1. Clone this repository:
On your local machine open a terminal session and enter the following commands for SSH or HTTPS to clone the repositiory.


- using ssh key <br>
```shell
$ git clone git@github.com:psitosam/rails-engine-lite.git
```

- using https <br>
```shell
$ git clone https://github.com/psitosam/rails-engine-lite.git
```

Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Rails Engine Lite project directory.

```shell
$ cd rails-engine-lite
```

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.

```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, run the following command.

```shell
$ bundle install
```

There should be be verbose text displayed of the installation process...followed by something similar to this line:
```shell
Bundle complete! 16 Gemfile dependencies, 70 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

## Database Migration:

4. Database Migration<br>
Before using the web application you will need to setup your databases locally by running the following command:

```shell
$ rails db: {:drop, :create, :migrate, :seed}
```

5. Pg Dump Load
Next we will seed environment with generic data by using CSV files by running the following command

```shell
$ rails db:schema:dump
```

6. Startup and Access<br>
Finally, in order to use the web app you will have to start the server locally and access the app through a web browser.
- Start server
```shell
$ rails s
```

- Open web browser and visit link
    http://localhost:3000/

At this point you should be taken to the welcome page of the web-app. If you encounter any errors or have not reached the web-app please confirm you followed the steps above and that your environment is properly set up.



## Meta

### Contributors: See ``CONTRIBUTORS.txt`` for more information.

### Distributed under the MIT license. See ``LICENSE.txt`` for more information.

[https://github.com/psitosam/github-link](https://github.com/psitosam/)



<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
