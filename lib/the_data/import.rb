class TheData::Import
  # model BankPayment
  # column :amount, header: 'My name', field: -> {}
  # column :email, header: 'Email', field: -> {}

  class << self
    attr_reader :record, :columns

    def config
      raise 'should call in subclass'
    end

    def model(class_name)
      if class_name.respond_to?(:ancestors) && class_name.ancestors.include?(ActiveRecord::Base)
        @record = class_name
      else
        raise 'The collection must be a subclass of ActiveRecord::Base'
      end
    end

    def column(name, header: nil, field: nil)
      @columns ||= {}
      name = name.to_sym

      @columns[name] = {}

      if header.is_a?(String) && header.size > 0
        @columns[name][:header] = header
      else
        raise 'wrong header type'
      end

      if field.respond_to?(:call)
        @columns[name][:field] = field
      end

      self
    end

  end
end
