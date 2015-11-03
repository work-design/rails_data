require 'active_support/concern'
module TheData
  module Model
    extend ActiveSupport::Concern

    included do
      belongs_to :data_list, dependent: :destroy
    end

    def pdf_string
      if report_lists.size > 1
        pdf = CombinePDF.new
        report_lists.published.each do |list|
          pdf << CombinePDF.parse(list.pdf_string)
        end

        pdf.to_pdf
      else
        report_list.pdf_string
      end
    end

    module ClassMethods

    end

  end

end
