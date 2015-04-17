module Admin
  class SettingsController < Admin::AdminController
    before_action :set_admin_setting, only: [:show, :edit, :update, :destroy]

    # GET /admin/settings
    # GET /admin/settings.json
    def index
      # @adm_set = Setting.all
    end

    # GET /admin/settings/1
    # GET /admin/settings/1.json
    def show
    end

    def about
      @content = Setting.find_by_key('about-content')
    end

    def contact
      @content = Setting.find_by_key('contact-content')
    end

    def title
      @content = Setting.find_by_key('title')
    end

    # GET /admin/settings/new
    def new
      @adm_sets = Setting.new
    end

    # GET /admin/settings/1/edit
    def edit
    end

    # POST /admin/settings
    # POST /admin/settings.json
    def create
      @adm_sets = Setting.new(admin_setting_params)
      respond_to do |format|
        if @adm_sets.save
          format.html { redirect_to admin_setting_path(@adm_sets), notice: 'Setting created.' }
          format.json { render :show, status: :created, location: @adm_sets }
        else
          format.html { render :new }
          format.json { render json: @adm_sets.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/settings/1
    # PATCH/PUT /admin/settings/1.json
    def update
      respond_to do |format|
        if @adm_sets.update(admin_setting_params)
          format.html { redirect_to [:admin, :settings], notice: 'Setting updated.' }
          format.json { render :show, status: :ok, location: @adm_sets }
        else
          format.html { render :edit }
          format.json { render json: @adm_sets.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/settings/1
    # DELETE /admin/settings/1.json
    def destroy
      @adm_sets.destroy
      respond_to do |format|
        format.html { redirect_to admin_settings_url, notice: 'Setting destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_setting
      id = params[:id].to_i

      if id != 0
        @adm_sets = Setting.find(id)
      else
        @adm_sets = Setting.find_by_key(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_setting_params
      params.require(:setting).permit(:key, :value)
    end
  end
end
