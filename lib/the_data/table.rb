require 'csv'
require 'the_data/table/config'
require 'the_data/table/import'
require 'the_data/table/export'

class TheData::Table
  include TheData::Import
  include TheData::Export

  attr_reader :data_list_id,
              :collection,
              :columns

  # collection = -> { User.limit(10) }
  # columns = {
  #  name: {
  #    header: 'My name',
  #    field: -> {}
  #  },
  #  email: {
  #    header: 'Email',
  #    field: -> {}
  #  }
  #}

  def initialize(data_list_id)
    @data_list_id = data_list_id
    @collection = nil
    @columns = {}
  end

  def collection_result
    collection.call
  end

  def config
    raise 'should call in subclass'
  end

  def inflector
    @inflector = TheData.config.inflector
  end

  def self.config(*args)
    data_list_id = args.shift
    report = self.new(report_list_id)
    report.config(*args)
  end

  def self.to_table(*args)
    config(*args).to_table
  end

end
