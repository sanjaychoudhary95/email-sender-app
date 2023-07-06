# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: '3.0.0'

* Rails version: '6.0.6.1'

* Database: PostgreSQL

## Quick start
1) Install ruby bundler
```
gem install bundler
```
2) Install dependencies
```
bundle install
```

3)Create a database on your local PostgreSQL
```
CREATE DATABASE
rake db:create
```

4) Migrate database
```
rails db:migrate
```
5) Start the server
```
rails server
```
6) Run specs
```
bundle exec rspec
```

Note:
if you are getting the errors `Webpacker::Manifest::MissingEntryError` then install webpacker by given command
rails webpacker:install
