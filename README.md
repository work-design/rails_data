# RailsData

RailsData 是Rails应用处理数据的利器，简单强大； 
1. 可用于导出数据至多种格式，包括 json、csv、pdf、xlsx, 并能输出为在线图表；
2. 将 excel, csv 格式的文件导入到 Model 中；
RailsData is a MiddleMan for import data and export data, It can be used for generating complex report.
And It can transfer data to many format, Like: csv, pdf, html, xml and more.

## 特性
* 配置简单；
* 通过缓存数据，使得生产 pdf, excel 的速度大大加快；
* 分离数据及导出文件的样式;
* Strong, even data processing break off, It can be restore easily;

## 原理
Rails Data 可以满足多层次场景的数据查看和导出需求

1. 对数据实时性要求不高，但是对于查询效率要求很高：
   
根据查询字段生成 Materialized View 及对应 Model, 定时跑数据。

2. 对数据实时性要求高，但是可以等待数秒到数分钟（根据需要查阅的数据量）：

将可能从多个表取得并进行计算加工后的数据统一缓存到数据库，然后通知用户数据已生成，用户点击下载即可立即获得。




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
遵循 [MIT](https://opensource.org/licenses/MIT)
