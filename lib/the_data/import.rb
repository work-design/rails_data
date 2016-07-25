module TheData::Import

  def collect(collection)
    if collection.respond_to?(:call)
      @collection = collection
    else
      raise 'The collection must be callable'
    end
  end

  def column(name, header: nil, field: nil, footer: nil)
    if columns.keys.include?(name)
      raise 'The column is repeated'
    end

    name = name.to_sym
    columns[name] = {}

    if header.nil?
      columns[name][:header] = name.titleize
    elsif header.is_a?(String)
      columns[name][:header] = header
    else
      raise 'wrong header type'
    end

    if field.respond_to?(:call)
      columns[name][:field] = field
    else
      raise 'wrong field type'
    end

    if footer.present?
      columns[name][:footer] = footer
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
