# RailsData
RailsData is a MiddleMan for import data and export data, It can be used for generating complex report.
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

## How to use

#### step-1: Define table
The table defined the report's data format

[Define Report Table](docs/define-report-table.md)

#### step-3: (optional) Define report pdf's style
[Define report pdf style](docs/define-pdf-style)

# 依赖
[rails_role](https://github.com/work-design/rails_role)

## License
License 采用 [LGPL-3.0](https://opensource.org/licenses/LGPL-3.0).
