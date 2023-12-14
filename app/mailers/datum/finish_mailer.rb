module Datum
  class FinishMailer < ApplicationMailer

    def notify(table_list, notice_email)
      attachments['filename.pdf'] = table_list.to_pdf.render
      mail to: notice_email, subject: 'Generation Complete'
    end

  end
end
