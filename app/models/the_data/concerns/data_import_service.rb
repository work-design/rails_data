require 'roo'
class DataImportService
  attr_reader :sheet, :column_index

  def initialize(config, sheet_file)
    if File.extname(sheet_file.path) == '.xls'
      require 'roo-xls'
      xlsx = Roo::Excel.new(sheet_file)
    else
      xlsx = Roo::Excelx.new(sheet_file)
    end
    @sheet = xlsx.sheet(xlsx.sheets[0])
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
    @sheet.each do |row|
      results << column_index.map { |index| row[index] }
    end
    results
  end

end
