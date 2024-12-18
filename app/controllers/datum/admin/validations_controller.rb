module Datum
  class Admin::ValidationsController < Admin::BaseController
    before_action :set_template
    before_action :set_validation, only: [:show, :edit, :update, :destroy]

    def index
      @validations = @template.validations.page(params[:page])
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

    def set_validation
      @validation = @template.validations.find params[:id]
    end

  end
end
