require 'active_support/concern'
module TheData
  module Model
    extend ActiveSupport::Concern

    included do
      has_one :report_list, as: :reportable, dependent: :destroy
      has_many :report_lists, as: :reportable, dependent: :destroy
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

      def define_report(name)

        define_method "#{name}_id" do
          self.report_lists.where(reportable_name: name).first_or_create.id
        end

        define_method "#{name}_report_list" do
          rl = self.report_lists.where(reportable_name: name).first
          if rl.present?
            rl.add_to_worker
          else
            self.report_lists.create(reportable_name: name)
          end
        end

      end

    end

  end

end
