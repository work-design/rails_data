# Define Table

 Table is used for config report's export data format.

## A table is composed of:

 - A collection: include rows;
 - A row: include columns;
 - A column: related to a model object, directly or indirectly;

So, just config them.

#### step-1: Define a subclass inherit from TheData::Base


```ruby
# we usually place the file in app/reports/example_table
class ExampleTable < TheData::Table
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
class ExampleTable < TheData::Table

  def config(size)

    # the collection should respond to method `each`
    collect -> { User.one_report_scope(size) }

  end

end
```

#### step-3: Config Each Column
use for each collection element's method, to pass a method name or a lambda
the order is important, all columns order by It's defined order

```ruby
class ExampleTable < TheData::Table

  def initialize(size)

    # the collection should respond to method `each`
    collectection = -> { User.one_report_scope(size) }

    # with default header and default field method
    # default header use 'titleize' method to format
    # default field method equal column's name
    columns = [:name, :email]

    # with assigned header and default field method
    headers = { name: 'My name', email: 'Email' }

    # with assigned header and assigned field method
    fields = { name: -> { name } }
  end

end
```

#### Optional, config headers for the table
