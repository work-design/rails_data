module TheData::Import

  def collection(scope)
    if scope.respond_to?(:call)
      @collection = scope
    else
      raise 'The collection must be callable'
    end
  end

  def column(name, field: nil, header: nil, footer: nil)
    if columns.keys.include?(name)
      raise 'The column is repeated'
    end

    columns[name.to_sym] = {}

    if field.nil?
      columns[name.to_sym][:field] = name
    elsif field.is_a?(Symbol)
      columns[name.to_sym][:field] = field
    elsif field.respond_to?(:call)
      columns[name.to_sym][:field] = scope(name, field)
    else
      raise 'wrong field type'
    end

    if header.nil?
      columns[name.to_sym][:header] = default_header(name)
    elsif header.is_a?(String)
      columns[name.to_sym][:header] = header
    else
      raise 'wrong header type'
    end

    if footer.present?
      columns[name.to_sym][:footer] = header
    end

    self
  end

  def note(header: nil, footer: nil)
    @note_header = header
    @note_footer = footer

    self
  end

  private
  def check_input(options)
    extra = options.keys.map(&:to_sym) - columns
    if extra.present?
      raise 'Seems some column have been defined'
    end
  end

  def scope(name, body)
    unless body.respond_to?(:call)
      raise ArgumentError, 'The scope body needs to be callable.'
    end

    method_name = 'the_data_' + name.to_s

    collection_result.first.class.send(:define_method, method_name) do |*args|
      instance_exec(*args, &body)
    end

    method_name.to_sym
  end

end
