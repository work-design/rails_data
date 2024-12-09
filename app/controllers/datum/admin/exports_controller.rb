module Datum
  class Admin::ExportsController < Admin::BaseController
    before_action :set_template

    def index
      @template_items = @template.exports.page(params[:page])
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

  end
end
