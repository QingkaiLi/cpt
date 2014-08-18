class AudiosController < ApplicationController

  before_action :set_audio, only: [:update]
  # PATCH/PUT /audio/1
  # PATCH/PUT /audio/1.json
  def update
    if @audio.update audio: params[:file].tempfile.read
      render :json => @audio
    else
      render json: {error: true}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_audio
      @audio = Audio.find(params[:id])
    end

    def audio_params
      params.require(:audio).permit(:filename)
    end
end
