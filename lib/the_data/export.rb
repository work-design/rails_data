module TheData::Export
  # collect -> (params) { User.default_where(params) }
  # column :name, header: 'My name', field: -> {}
  # column :email, header: 'Email', field: -> {}
  attr_reader :collection,
              :columns,
              :parameters

  def config(*args, &block)
    block.call(*args) if block_given?
  end

  def collect(collection)
    @collection = collection
    @parameters ||= {}
    if collection.respond_to?(:call)
      @parameters << collection.parameters.to_combined_h[:key].values
    end
  end

  def column(name, header: nil, field: nil, footer: nil)
    @columns ||= {}
    name = name.to_sym

    if @columns.keys.include?(name)
      warn 'The column is repeated'
    end

    @columns[name] = {}

    if header.nil?
      @columns[name][:header] = name.titleize
    else
      @columns[name][:header] = header
    end
    @columns[name][:field] = field
    @columns[name][:footer] = footer

    if field.respond_to?(:call)
      @parameters << field.parameters.to_combined_h[:key].values
    end

    self
  end

end
