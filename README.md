Sample for Rails application with running tests in parallel
===========================================================

This sample illustrates how to run Cucumber tests in parallel on Shippable.

Splitting scenarios into groups
-------------------------------

We use [`cucumber_in_groups`](https://github.com/cloudcastle/cucumber_in_groups)
to split Cucumber scenarios into groups that will be then executed in parallel.

We add it to `Gemfile` as follows (at the moment of writing, the version available
on RubyGems was not compatible with Rails 4):

    group :test do
      gem 'cucumber-rails', :require => false
      gem 'cucumber_in_groups', :require => false, :git => 'git://github.com/cloudcastle/cucumber_in_groups.git'
    end

Then, in `cucumber.yml`:

    <% require 'cucumber_in_groups' %>
    default: --profile ci --profile dev
    ci: --format junit --out <%= ENV['CI_REPORTS'] %>
    dev: <%= std_opts %> <%= grouped_features %>

(refer to the sections below for details on Capybara+Cucumber configuration for
Shippable)

Finally, we can run specific group of features by setting `GROUP` environment
variable.

    env:
      matrix:
        - GROUP=1of3
        - GROUP=2of3
        - GROUP=3of3

Please note that the above will trigger three builds, to cover all the combinations
of the build settings. These builds will run in parallel only if number of available
minions is greater or equal to three.

Please refer to
[Shippable documentation](http://docs.shippable.com/en/latest/config.html#build-matrix)
on matrix builds for details.

Using Selenium
--------------

To simulate long-running tests, this sample uses Selenium to execute scenarios
tagged with `@javascript`.
To make Selenium available in Shippable
environment, we need to add the following lines to the `shippable.yml` file:

    addons:
      firefox: "28.0"
    services:
      - selenium

    env:
      global:
        - DISPLAY=:99.0

    before_script: 
      - /etc/init.d/xvfb start 

    after_script:
      - /etc/init.d/xvfb stop

It will make sure that Selenium is installed on the minion and will start and then stop virtual
framebuffer device for X server to render to.

Also, remember to install the required gems by adding the following entries to the `Gemfile`:

    group :test do
      gem 'cucumber-rails', :require => false
      gem 'database_cleaner'
      gem 'selenium-webdriver'
    end

Configuring test reporting
--------------------------

To have Cucumber output test and coverage reports to the directories expected by Shippable, we need
to declare the following environment variables:

    env:
      global:
        - CI_REPORTS=shippable/testresults COVERAGE_REPORTS=shippable/codecoverage

Then, add the following entries to the `Gemfile`:

    group :test do
      gem 'simplecov'
      gem 'simplecov-csv'
    end

Finally, initialize the coverage support in `features/support/env.rb`:

    require 'simplecov'
    require 'simplecov-csv'
    SimpleCov.formatter = SimpleCov::Formatter::CSVFormatter
    SimpleCov.coverage_dir(ENV["COVERAGE_REPORTS"])
    SimpleCov.start 'rails'

And add the required options to Cucumber invocation by modifying `config/cucumber.yml`:

    default: --profile ci --profile dev
    ci: --format junit --out <%= ENV['CI_REPORTS'] %>
    dev: <%= std_opts %> features

For more detailed documentation, please see [section on Selenium](http://docs.shippable.com/en/latest/config.html#selenium) in Shippable docs.

This sample is built for Shippable, a docker based continuous integration and deployment platform.
