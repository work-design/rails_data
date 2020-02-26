module RailsData::Export

  # extend RailsData::Export
  # config do
  #   collect -> (params) { User.default_where(params) }
  #   def_x_column :date, header: 'Date'
  #   column :name, header: 'My name', field: -> {}
  #   column :email, header: 'Email', field: -> {}
  # end
  attr_reader :collection, :x_field, :columns, :parameters

  def config(*args, &block)
    block.call(*args) if block_given?
  end

  def collect(collection)
    @collection = collection
    @parameters ||= []
    if collection.respond_to?(:call)
      _params = collection.parameters.to_array_h.to_combine_h
      @parameters << _params[:key] if _params[:key]
    end
  end

  # will use for x field with chart
  def x_column(name, header: nil, field: nil, footer: nil)
    if @x_field.present?
      warn 'The x column is present'
    end
    @x_field = name.to_sym
    column(name, header: header, field: field, footer: footer)
  end

  def column(name, header: nil, field: nil, footer: nil)
    @columns ||= {}
    name = name.to_sym

    if @columns.key?(name)
      warn 'The column is repeated'
    end

    @columns[name] = {}

    if header.nil?
      @columns[name][:header] = name.titleize
    else
      @columns[name][:header] = header
    end
    @columns[name][:field] = field
    @columns[name][:footer] = footer if footer

    if field.respond_to?(:call)
      _params = field.parameters.to_array_h.to_combine_h
      @parameters << _params[:key] if _params[:key]
    end

    self
  end

end
