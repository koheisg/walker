class FeedGroupsController < ApplicationController
  before_action :set_feed_group, only: %i[ show edit update destroy ]

  # GET /feed_groups or /feed_groups.json
  def index
    @feed_groups = FeedGroup.all
  end

  # GET /feed_groups/1 or /feed_groups/1.json
  def show
  end

  # GET /feed_groups/new
  def new
    @feed_group = FeedGroup.new
  end

  # GET /feed_groups/1/edit
  def edit
  end

  # POST /feed_groups or /feed_groups.json
  def create
    @feed_group = FeedGroup.new(feed_group_params)

    respond_to do |format|
      if @feed_group.save
        format.html { redirect_to feed_group_url(@feed_group), notice: "Feed group was successfully created." }
        format.json { render :show, status: :created, location: @feed_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_groups/1 or /feed_groups/1.json
  def update
    respond_to do |format|
      if @feed_group.update(feed_group_params)
        format.html { redirect_to feed_group_url(@feed_group), notice: "Feed group was successfully updated." }
        format.json { render :show, status: :ok, location: @feed_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_groups/1 or /feed_groups/1.json
  def destroy
    @feed_group.destroy

    respond_to do |format|
      format.html { redirect_to feed_groups_url, notice: "Feed group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_group
      @feed_group = FeedGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_group_params
      params.require(:feed_group).permit(:name, :default, feed_ids: [])
    end
end
