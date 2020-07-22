***********************
Ingest Application Data 
***********************

Ruby on Rails
=============

This is easy: You just need to combine a few components.

Log all requests and logger calls into Graylog
-----------------------------------------------

The recommended way to send structured information (i.e. HTTP return code, action, controller, ... in additional fields) about every request and
explicit ``Rails.logger`` calls is easily accomplished using the `GELF gem <https://rubygems.org/gems/gelf>`__ and
`lograge <https://github.com/roidrage/lograge>`__. Lograge builds one combined log entry for every request (instead of several lines like the
standard Rails logger) and has a Graylog output since version 0.2.0.

Start by adding Lograge and the GELF gem to your Gemfile::

  gem "gelf"
  gem "lograge"

Now configure both in your Rails application. Usually ``config/environments/production.rb`` is a good place for that::

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Graylog2.new
  config.logger = GELF::Logger.new("graylog.example.org", 12201, "WAN", { :host => "hostname-of-this-app", :facility => "heroku" })

This configuration will also send all explicit ``Rails.logger`` calls (e.g. ``Rails.logger.error "Something went wrong"``) to Graylog.

Log only explicit logger calls into Graylog
-------------------------------------------

If you don't want to log information about every request, but only explicit ``Rails.logger`` calls, it is enough to only configure the Rails logger.

Add the GELF gem to your Gemfile::

  gem "gelf"

...and configure it in your Rails application. Usually ``config/environments/production.rb`` is a good place for that::

  config.logger = GELF::Logger.new("graylog.example.org", 12201, "WAN", { :host => "hostname-of-this-app", :facility => "heroku" })

Heroku
------

You need to apply a workaround if you want custom logging on Heroku. The reason for this is that Heroku injects an own logger (``rails_log_stdout``),
that overwrites your custom one. The workaround is to add a file that makes Heroku think that the logger is already in your application::

    $ touch vendor/plugins/rails_log_stdout/heroku_fix