require 'csv'
require 'one_report/base/config'
require 'one_report/base/import'
require 'one_report/base/export'

class TheData::Base
  include TheData::Import
  include TheData::Export

  attr_accessor :report_list_id,
                :collection,
                :columns,
                :headers,
                :footers,
                :fields,
                :arguments

  def initialize(report_list_id)
    @report_list_id = report_list_id
    @collection = nil
    @columns = []
    @headers = {}
    @footers = {}
    @fields = {}
    @arguments = {}
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

  def header_values
    @header_values = headers.values_at(*columns)
  end

  def footer_values
    @footer_values = footers.values_at(*columns)
  end

  def field_values
    @field_values = fields.values_at(*columns)
  end

  def self.config(*args)
    report_list_id = args.shift
    report = self.new(report_list_id)
    report.config(*args)
  end

  def self.to_table(*args)
    config(*args).to_table
  end

end
