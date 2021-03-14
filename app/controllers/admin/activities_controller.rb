module Admin
  class ActivitiesController < ApplicationController
    layout "admin"
    before_action :set_activity, only: %i[show edit update destroy]

    # GET /activities
    # GET /activities.json
    def index
      @pagy, @activities = pagy(Activity.all, max_items: 5)
    end

    # GET /activities/1
    # GET /activities/1.json
    def show; end

    # GET /activities/new
    def new
      @activity = Activity.new
    end

    # GET /activities/1/edit
    def edit; end

    # POST /activities
    # POST /activities.json
    def create
      @activity = Activity.new(activity_params)

      respond_to do |format|
        if @activity.save
          format.html { redirect_to [:admin, @activity], success: "Activity was successfully created." }
          format.json { render :show, status: :created, location: @activity }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /activities/1
    # PATCH/PUT /activities/1.json
    def update
      respond_to do |format|
        if @activity.update(activity_params)
          format.html { redirect_to [:admin, @activity], success: "Activity was successfully updated." }
          format.json { render :show, status: :ok, location: @activity }
        else
          format.html { render :edit }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /activities/1
    # DELETE /activities/1.json
    def destroy
      @activity.destroy
      respond_to do |format|
        format.html { redirect_to admin_activities_url, notice: "Activity was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.includes(:variations).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :simple_desc, :detail_desc, :location, :category, :set_label,
                                       :has_weight, :machine_based)
    end
  end
end
