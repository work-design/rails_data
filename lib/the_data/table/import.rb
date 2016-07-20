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

    if field.nil?
      columns[:field] = name
    elsif field.is_a?(Symbol)
      columns[:field] = field
    elsif field.respond_to?(:call)
      columns[:field] = scope(name, field)
    else
      raise 'wrong field type'
    end

    if header.nil?
      default_header(name)
    elsif header.is_a?(String)
      headers.merge!(name => header)
    else
      raise 'wrong header type'
    end

    if footer.present?
      footers.merge!(name => footer)
    end

    self
  end

  def default_headers(name)
    name.to_s.titleize
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
