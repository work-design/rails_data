class Combine < ActiveRecord::Base
  attachment :file
  has_many :combine_data_lists, dependent: :delete_all
  has_many :data_lists, through: :combine_data_lists
  has_many :table_lists, through: :data_lists

  after_commit :add_to_worker, on: :create

  def run(save = true)
    remove_file_save
    self.pdf_to_file if save
  end

  def pdf_string
    pdf = CombinePDF.new
    report_lists.published.each do |list|
      pdf << CombinePDF.parse(list.pdf_string)
    end

    pdf.to_pdf
  end

  def add_to_worker
    CombineWorker.perform_in(500, self.id)
  end

end
