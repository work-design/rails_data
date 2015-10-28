## How it works
* there is a Model ReportList Associate to the model which has a report, ReportList records information as bellow:

| column name | column type | explain |example |
|--|--|--|--|
| reportable_id | integer | association id | 1 |
| reportable_type | string | association type | StudentReport |
| reportable_name | string | the defined report name | sports_report |
| file_id || report file information, use refile admin file | |
| file_filename |||
| file_size |||
| file_content_type | ||
| notice_email ||notice Functions |
| notice_body ||
| done | |status Functions |
| published |||
```
