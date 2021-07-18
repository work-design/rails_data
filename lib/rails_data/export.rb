module RailsData::Export

  # extend RailsData::Export
  # config do
  #   collect -> (params) { User.default_where(params) }
  #   column :date, header: 'Date', x_axis: true
  #   column :name, header: 'My name', field: -> {}
  #   column :email, header: 'Email', field: -> {}
  # end
  attr_reader :collection, :columns, :parameters

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

  # x_axis: will use for x field with chart
  def column(header:, key: nil, field: nil, footer: nil, x_axis: false)
    @columns ||= []
    col = {}

    col[:key] = key
    col[:header] = header
    col[:field] = field
    col[:footer] = footer if footer
    col[:x_axis] = true if x_axis

    @columns << col
    self
  end

end
