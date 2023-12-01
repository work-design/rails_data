require 'csv'
require 'write_xlsx'

module Datum
  module Model::TableList
    extend ActiveSupport::Concern

    included do
      attribute :parameters, :json, default: {}
      attribute :headers, :string, array: true, default: []
      attribute :footers, :string, array: true, default: []
      attribute :table_items_count, :integer, default: 0
      attribute :timestamp, :string
      attribute :done, :boolean
      attribute :published, :boolean

      belongs_to :data_list, optional: true
      has_many :table_items, dependent: :delete_all

      has_one_attached :file
    end

    def run
      clear_old
      if data_list.is_a? DataImport
        runner = Importer.new(self)
      else
        runner = CacheExporter.new(self)
      end
      runner.run
    end

    def convert_parameters
      params = {}.with_indifferent_access
      parameters.each do |k, v|
        params.merge! k => v.send(DefaultForm.config.mapping[data_list.parameters[k].to_sym][:output])
      end
      params
    end

    def to_pdf
      export = PdfExporter.new(self)
      export.run
    end

    def direct_xlsx
      export = XlsxExporter.new(export: self.data_list.export, params: self.parameters)
      export.run
    end

    def cached_xlsx
      io = StringIO.new
      workbook = WriteXLSX.new(io)
      sheet = workbook.add_worksheet

      sheet.write_row(0, 0, headers)
      table_items.each_with_index do |table_item, index|
        sheet.write_row(index + 1, 0, table_item.fields)
      end
      sheet.write_row table_items_count + 1, 0, footers

      workbook.close
      io.string
    end

    def export_ary
      ary = []
      ary << headers
      table_items.each do |table_item|
        ary << table_item.fields
      end
      ary
    end

    def export_csv
      csv = ''
      csv << headers.to_csv
      self.table_items.each do |table_item|
        csv << table_item.fields.to_csv
      end
      csv
    end

    def export_json(*columns)
      indexes = {}
      columns.each { |column| indexes.merge! column => headers.index(column) }
      indexes.compact!

      table_items.map do |table_item|
        r = {}
        indexes.each do |column, index|
          r.merge! column => table_item.fields[index]
        end
        r
      end
    end

    def x_field
      headers[data_list.x_position] if data_list.x_position
    end

    def export_chart_json(column)
      export_json(x_field, column)
    end

    def cached_run(_timestamp = nil)
      unless self.timestamp.present? && self.timestamp == _timestamp.to_s
        self.timestamp = _timestamp
        run
      end
    end

    def clear_old
      self.done = false
      self.class.transaction do
        self.save!
        table_items.delete_all
      end
    end

    def file_name(format)
      name = self.id || 'example'
      "#{name}.#{format}"
    end

  end
end
