require 'roo'

class TheDataImport
  attr_reader :sheet, :column_index

  def initialize(config, sheet_file)
    xlsx = Roo::Excelx.new(sheet_file)
    @sheet = xlsx.sheet_for(xlsx.sheets[0])
    @config = config

    @column_index = init_header.compact
  end

  def init_header
    headers = @config.columns.map { |_, v| v[:header] }
    file_header = @sheet.row(1)

    headers.map do |header|
      file_header.find_index(header)
    end
  end

  def results
    results = []
    @sheet.each_row do |row|
      results << column_index.map { |index| row[index].value }
    end
    results
  end

end
