class TheData::Record
  # object -> { Order.find order_id }
  # column :amount, header: 'My name', field: -> {}
  # column :email, header: 'Email', field: -> {}

  class << self
    attr_reader :record, :columns

    def config
      raise 'should call in subclass'
    end

    def config_column
      raise 'should call in subclass'
    end

    def config_object
      raise 'should call in subclass'
    end

    def object(object)
      if object.respond_to?(:call)
        @record = object
      else
        raise 'The Record must be callable'
      end
    end

    def column(name, field: nil, type: nil)
      @columns ||= {}
      name = name.to_sym

      @columns[name] = {}

      if field.respond_to?(:call)
        @columns[name][:field] = field
      end

      if type
        @columns[name][:type] = type
      else
        @columns[name][:type] = 'string'
      end

      @columns
    end

  end
end
