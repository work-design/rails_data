module Datum
  class Admin::TemplateExamplesController < Admin::BaseController
    before_action :set_template

    def index
      @template_examples = @template.template_examples.page(params[:page])
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

  end
end
