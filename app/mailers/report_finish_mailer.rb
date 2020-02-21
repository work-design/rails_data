class ReportFinishMailer < ApplicationMailer

  def finish_notify(id)
    @report_list = ReportList.find(id)
    @message = @report_list.notice_body

    if Rails.env == 'production'
      @email = @report_list.notice_email
    else
      @email = 'mingyuan0715@foxmail.com'
    end

    mail to: @email, subject: 'Generation Complete'
  end

end
