module Admin
  class ProvincesController < AdminController

    before_action :set_admin_province, only: [:show, :edit, :update]

    # GET /admin/provinces
    # GET /admin/provinces.json
    def index
      @provinces = Province.all
    end

    # GET /admin/provinces/1/edit
    def edit
    end

    # PATCH/PUT /admin/provinces/1
    # PATCH/PUT /admin/provinces/1.json
    def update
      respond_to do |format|
        if @admin_province.update(admin_province_params)
          format.html { redirect_to admin_provinces_path, notice: 'Province was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_province }
        else
          format.html { render :edit }
          format.json { render json: @admin_province.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_province
      @admin_province = Province.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_province_params
      params.require(:province).permit(:pst, :gst, :hst)
    end
  end
end