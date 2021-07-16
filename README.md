# RailsData

RailsData 是Rails应用处理数据的利器，简单强大； 
1. 可用于导出数据至多种格式，包括 csv,pdf, xlsx, 并能输出为在线图表；
2. 将 excel, csv 格式的文件导入到 Model 中；
RailsData is a MiddleMan for import data and export data, It can be used for generating complex report.
And It can transfer data to many format, Like: csv, pdf, html, xml and more.

## 特性
* 配置简单；
* 通过缓存数据，使得生产 pdf, excel 的速度大大加快；
* 分离数据及导出文件的样式;
* Strong, even data processing break off, It can be restore easily;

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
* [rails_com](https://github.com/work-design/rails_com)
  * [default_where](https://github.com/qinmingyuan/default_where)
  * [default_form](https://github.com/qinmingyuan/default_form)

## 许可证
* [MIT](https://opensource.org/licenses/MIT)
