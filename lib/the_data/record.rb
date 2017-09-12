class TheData::Record
  # model BankPayment
  # column :amount, header: 'My name', field: -> {}
  # column :email, header: 'Email', field: -> {}

  class << self
    attr_reader :record, :columns

    def config
      raise 'should call in subclass'
    end

    def object(object)
      @record = object
    end

    def column(name, field: nil)
      @columns ||= {}
      name = name.to_sym

      @columns[name] = {}

      if field.respond_to?(:call)
        @columns[name][:field] = field
      end

      self
    end

  end
end
