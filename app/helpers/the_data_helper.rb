module TheDataHelper

  def text_field_tag(name, value = nil, options = {})
    if options[:as]
      type = TheData.config.mapping[options[:as]][:input]

      if type == 'textarea'
        return text_area_tag(name, value, options)
      end

      if type == 'select'
        opts = TheData.config.mapping[options[:as]][:options]
        selected = TheData.config.mapping[options[:as]][:selected]
        return select_tag name, options_for_select(opts, selected), options
      end
    end

    super
  end

end