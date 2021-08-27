module Datum
  class FinishMailer < ApplicationMailer

    def finish_notify(data_list)
      @message = data_list.notice_body
      mail to: data_list.notice_email, subject: 'Generation Complete'
    end

  end
end
