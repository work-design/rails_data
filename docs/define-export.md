# Define Table

 Export is used for config report's export data format.

## A table is composed of:

 - A collection: include rows;
 - A row: include columns;
 - A column: related to a model object, directly or indirectly;

So, just config them.

#### step-1: Define a subclass inherit from RailsData::Base


```ruby
# we usually place the file in app/reports/example_table
class ExampleTable
  extend RailsData::Export
end
```

#### step-2: Config Collection

- Before config collection, you should defined a scope for the Model first

```ruby
# consider a User model
# need define some scope before used it;
class User
  scope :one_report_scope, ->(size) { limit(size) }
end
```

- call `collect` method for define collection, the params should be a lambda, and the collection should response to method `each`

```ruby
class ExampleTable 
  extend RailsData::Export

  config(size) do
    # the collection should respond to method `each`
    collect -> (params) { User.default_where(params) }

    # with default header and default field method
    # default header use 'titleize' method to format
    # default field method equal column's name
    column :name

    # with assigned header and default field method
    column :name, header: 'My name'

    # with assigned header and assigned field method
    column :name, header: 'My name', field: -> { name }
  end

end
```

#### step-3: Config Each Column
use for each collection element's method, to pass a method name or a lambda
the order is important, all columns order by It's defined order




```ruby
{
  name: {
    header: 'My name',
    field: -> {}
  },
  email: {
    header: 'Email',
    field: -> {}
  }
}
```

#### Optional, config headers for the table
