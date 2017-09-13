module TheDataHelper

  def text_field_tag(name, value = nil, options = {})
    if options[:type] == 'textarea'
      return text_area_tag(name, value, options)
    end

    super
  end

end