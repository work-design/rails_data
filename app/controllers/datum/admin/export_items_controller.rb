module Datum
  class Admin::ExportItemsController < Admin::BaseController
    before_action :set_export
    before_action :set_new_export_item, only: [:new, :create]

    def index
      @export_items = @export.export_items.page(params[:page])
    end

    private
    def set_export
      @export = Export.find params[:export_id]
    end

    def set_new_export_item
      @export_item = @export.export_items.build(export_item_params)
    end

    def export_item_params
      result = params.fetch(:export_item, {}).permit(
        extra: {}
      )
      result[:extra].compact_blank! if result[:extra]
      result
    end

  end
end
