# TheData
TheData is a MiddleMan for import data and export data, It can be used for generating complex report.
And It can transfer data to many format, Like: csv, pdf, html, xml and more.

## Features
- Easy to use, Just config;
- Separate pdf style and data;
- Strong, even data processing break off, It can be restore easily;

## Functions
- sidekiq job;
- report file store;
- send email notice user after finished sidekiq job;

## Getting Started

#### step-1: Add one_report to you Gemfile:

```ruby
gem 'the_data'
```

#### step-2: Run migrations

```bash
rake the_auth_engine:install:migrations
rake db:migrate
```

## How to use

#### step-1: Define table
The table defined the report's data format

[Define Report Table](doc/define-report-table.md)

#### step-2: Define report method
[Define Report Method](doc/define-report-method.md)

#### step-3: (optional) Define report pdf's style
[Define report pdf style](doc/define-pdf-style)

# 依赖
[the_role](https://github.com/yigexiangfa/the_role)