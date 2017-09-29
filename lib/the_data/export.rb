class TheData::Export
  # collect -> { User.limit(10) }
  # column :name, header: 'My name', field: -> {}
  # column :email, header: 'Email', field: -> {}

  class << self
    attr_reader :collection, :columns

    def config
      raise 'should call in subclass'
    end

    def collect(collection)
      if collection.respond_to?(:call)
        @collection = collection
      else
        raise 'The collection must be callable'
      end
    end

    def column(name, header: nil, field: nil, footer: nil)
      @columns ||= {}
      name = name.to_sym

      # if @columns.keys.include?(name)
      #
      #   binding.pry
      #
      #   raise 'The column is repeated'
      # else
      #   binding.pry
      # end

      @columns[name] = {}

      if header.nil?
        @columns[name][:header] = name.titleize
      elsif header.is_a?(String)
        @columns[name][:header] = header
      else
        raise 'wrong header type'
      end

      if field.respond_to?(:call)
        @columns[name][:field] = field
      else
        raise 'wrong field type'
      end

      if footer.present?
        @columns[name][:footer] = footer
      end

      self
    end

  end
end
