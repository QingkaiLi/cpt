class PronunciationsController < ApplicationController
  before_action :set_pronunciation, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /pronunciations
  # GET /pronunciations.json
  def index
    if params[:per_page] == nil
      @per_page = 30
    elsif params[:per_page].to_i < 1
      @per_page = Pronunciation.count
    else
      @per_page = params[:per_page].to_i
    end
    @order = params[:order] ? params[:order] : 'asc'
    # @order = params[:order] || 'asc'
    @search = params[:search]
    @filter = params[:filter]
    @pronunciations = Pronunciation
                          .select('pronunciations.*', 'group_concat(phonemes SEPARATOR \', \') as phoneme')
                          .includes(:pronunciation_status)
                          .search(@search, @filter)
                          .order("dictionary_key #@order")
                          .group('dictionary_key')
                          .paginate(page: params[:page], per_page: @per_page)
    @referer_url = session[:referer_url] ||= root_path
  end

  # GET /pronunciations/1
  # GET /pronunciations/1.json
  def show
  end

  # GET /pronunciations/new
  def new
    @pronunciation = Pronunciation.new
  end

  # GET /pronunciations/1/edit
  def edit
  end

  # POST /pronunciations
  # POST /pronunciations.json
  def create
    @pronunciation = Pronunciation.new pronunciation_params
    
    respond_to do |format|
      if @pronunciation.save
        format.html { redirect_to @pronunciation, notice: 'Pronunciation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pronunciation }
      else
        format.html { render action: 'new' }
        format.json { render json: @pronunciation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pronunciations/1
  # PATCH/PUT /pronunciations/1.json
  def update
    case params[:phonemes]
    when nil
      @pronunciation.pronunciation_status = PronunciationStatus.approved
      @pronunciation.user = current_user
    when ''
      @pronunciation.phonemes = params[:phonemes]
      @pronunciation.pronunciation_status = PronunciationStatus.missing
    else
      @pronunciation.phonemes = params[:phonemes]
      @pronunciation.pronunciation_status = PronunciationStatus.needs_review
    end
    if @pronunciation.save
      render :json => @pronunciation.to_json(
        :only => [:dictionary_key, :phonemes],
        :include => {:user => {:only => :name}, :pronunciation_status => {:only => :name}}
      )
    else
      render json: @pronunciation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pronunciations/1
  # DELETE /pronunciations/1.json
  def destroy
    @pronunciation.destroy
    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pronunciation
      @pronunciation = Pronunciation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pronunciation_params
      params[:pronunciation].permit(:dictionary_key, :phonemes)
    end
end
