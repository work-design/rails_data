module TheData::Import

  def collect(scope)
    if scope.respond_to?(:call)
      @collection = scope
    else
      raise 'The scope must be callable'
    end

    self
  end

  def column(name, field: nil, header: nil, argument: nil, footer: nil)
    unless name.is_a?(Symbol)
      raise 'please pass a symbol for column name'
    end

    if @columns.include?(name)
      raise 'The column is repeated'
    end

    columns << name

    if field.nil?
      fields.merge!(name => name)
    elsif field.equal?(false)
      fields.merge!(name => nil)
    elsif field.is_a?(Symbol)
      fields.merge!(name => field)
    elsif field.respond_to?(:call)
      fields.merge!(name => scope(name, field))
    else
      raise 'wrong field type'
    end

    if header.nil?
      header_default(name)
    elsif header.is_a?(String)
      headers.merge!(name => header)
    else
      raise 'wrong header type'
    end

    if footer.present?
      footers.merge!(name => footer)
    end

    if argument && argument.is_a?(Array)
      arguments.merge!(name => argument)
    else
      raise 'wrong argument type'
    end

    self
  end

  def note(header: nil, footer: nil)
    @note_header = header
    @note_footer = footer

    self
  end

  private
  def header_default(name)
    h = {name => name.to_s.send(inflector)}
    headers.merge! h
  end

  def scope(name, body)
    unless body.respond_to?(:call)
      raise ArgumentError, 'The scope body needs to be callable.'
    end

    method_name = 'one_report_' + name.to_s

    collection_result.first.class.send(:define_method, method_name) do |*args|
      instance_exec(*args, &body)
    end

    method_name.to_sym
  end

end
