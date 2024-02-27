require 'prawn/table'
module Datum
  class PdfExporter < CacheExporter

    def initialize(table_list)
      super
      @config_pdf = table_list.data_list.config_pdf
    end

    def pdf
      if @config_pdf
        @pdf ||= @config_pdf
      else
        @pdf ||= TopHeaderTablePdf.new
      end
    end

    def remove_file_save
      self.remove_file = true
      self.save
      self.remove_file = nil
    end

    def pdf_data
      if file_id
        file.read
      else
        pdf_string
      end
    end

    def pdf_string
      pdf_result.render
    end

    def pdf_result
      pdf.table_data = [table_list.export_ary]
      pdf.header_data = header_data
      pdf.ending_data = ending_data
      pdf.run
      pdf
    end

    def header_data
      if table_list.respond_to? :header_info
        table_list.header_info
      else
        [
          ['', ''],
          ['', '']
        ]
      end
    end

    def ending_data
      if table_list.respond_to? :ending_data
        table_list.try(:ending_data)
      else
        ''
      end
    end

    def filename(extension = 'pdf')
      if file_filename.present?
        filename = file_filename
      elsif reportable.respond_to?(:filename)
        filename = reportable.filename
      else
        filename = "#{reportable_name.camelize}-#{reportable_id}"
      end

      unless filename.end_with?(extension)
        filename << '.' << extension
      end

      filename
    end

  end
end
