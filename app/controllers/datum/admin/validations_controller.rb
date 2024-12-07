module Datum
  class Admin::ValidationsController < Admin::BaseController
    before_action :set_template

    def index
      @validations = @template.validations.page(params[:page])
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

  end
end
