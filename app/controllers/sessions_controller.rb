class SessionsController < ApplicationController
  skip_before_action :authenticate

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # POST /sessions or /sessions.json
  def create
    @session = Session.new(session_params)

    if @session.save
      cookies.encrypted[:user_id] = @session.id
      redirect_to feeds_url, notice: "Session was successfully created."
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1 or /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: "Session was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
