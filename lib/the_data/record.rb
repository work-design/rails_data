class TheData::Record
  # object -> { Order.find order_id }
  # column :amount, header: 'My name', field: -> {}
  # column :email, header: 'Email', field: -> {}
  attr_reader :record, :columns

  def config(&block)
    block.call if block_given?
  end

  def config_column(&block)
    block.call if block_given?
  end

  def config_object(&block)
    block.call if block_given?
  end

  def object(object)
    if object.respond_to?(:call)
      @record = object
    else
      raise 'The Record must be callable'
    end
  end

  def column(name, field: nil, as: nil)
    @columns ||= {}
    name = name.to_sym

    @columns[name] = {}

    if field.respond_to?(:call)
      @columns[name][:field] = field
    end

    if as
      @columns[name][:as] = as
    else
      @columns[name][:as] = 'string'
    end

    @columns
  end

end
