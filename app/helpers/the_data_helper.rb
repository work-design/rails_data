module TheDataHelper

  def text_field_tag(name, value = nil, options = {})
    type = TheData.config.mapping[options[:as].to_sym][:input]


    if type == 'textarea'
      return text_area_tag(name, value, options)
    end

    if type == 'select'
      return select_tag name, options_for_select(TheData.config.mapping[options[:as].to_sym][:options]), options
    end

    options[:type] = type
    super
  end

end