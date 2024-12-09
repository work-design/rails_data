module Datum
  class Admin::ExportsController < Admin::BaseController
    before_action :set_template
    before_action :set_export, only: [:show, :edit, :update, :destroy]
    before_action :set_new_export, only: [:new, :create]

    def index
      @exports = @template.exports.page(params[:page])
    end

    def show
      respond_to do |format|
        format.html
        format.turbo_stream
        format.xlsx { send_data @export.export, filename: "#{@export.name}.xlsx", type: 'application/xlsx' }
      end
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

    def set_export
      @export = @template.exports.find params[:id]
    end

    def set_new_export
      @export = @template.exports.build(export_params)
    end

    def export_params
      params.fetch(:export, {}).permit(
        :name
      )
    end

  end
end
