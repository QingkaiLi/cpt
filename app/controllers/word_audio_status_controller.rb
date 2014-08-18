class WordAudioStatusController < ApplicationController
  before_action :word_audio_status_params, only: [:update]
  before_action :authorize
  before_action :save_referer, only: [:index]
  before_action :set_word_audio_status, only: [:show, :update, :edit]

  # GET /word_audio_status
  # GET /word_audio_status.json
  def index
    @search_key_word ||= params[:search_text]

    @per_page = params[:per_page] || 30

    @filter =  params[:filter]

    filter = ""
    if !params[:filter] == 'No Audio Enabled'
      filter = ' and color == 1'
    elsif !params[:filter].blank?
      filter = " and audio_statuses.name = '#{@filter}'"
    end

    @word_audio_statuses = WordAudioStatus
              .select('word_audio_statuses.*', 'ww.num','audio_statuses.name', '(ww.enabled=0 && ww.num is not null) as color')
              .joins('left join audio_statuses on audio_statuses.id = word_audio_statuses.audio_status_id')
              .joins("left join (select count(0) as num, sum(enabled) enabled, spelling from word_audio_statuses group by spelling having num > 1) ww on ww.spelling = word_audio_statuses.spelling")
              .order('word_audio_statuses.spelling')
              .paginate(page: params[:page],
                        per_page: (@per_page.to_i<0 ? WordAudioStatus.count.to_s : @per_page),
                        conditions: ["word_audio_statuses.spelling like ? #{filter}", "%#{@search_key_word}%"])
  end

  # GET /word_audio_status/1
  # GET /word_audio_status/1.json
  def show
    render :layout => false
  end

  # GET /word_audio_status/1/edit
  def edit
    render :layout => false
  end

  # PATCH/PUT /word_audio_status/1
  # PATCH/PUT /word_audio_status/1.json
  def update
    @word_audio_status.user = @current_user
    if @word_audio_status.update_with_status params[:word_audio_status][:audio_status_name], word_audio_status_params
      if params[:word_audio_status][:audio_status_name] == AudioStatus::AUDIO_STATUS_APPROVED
        render 'show', :layout => false
      end
      @color_status = WordAudioStatus.select('count(0) AS num', 'sum(enabled) AS enabled', :spelling).where(spelling: @word_audio_status.spelling).group(:spelling).first
    else
      render json: @word_audio_status.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word_audio_status
      @word_audio_status = WordAudioStatus.find(params[:id])
    end

    def word_audio_status_params
      params.require(:word_audio_status).permit(:enabled, :description)
    end

    def save_referer
      if request.referer
        if !URI(request.referer).path.in? ['/word_audio_status','/pronunciations']
          session[:referer_url] = request.referer
          @referer_url = request.referer
        end
      else
        @referer_url = root_path
      end
    end
end
