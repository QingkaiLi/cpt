class ContentPacksController < ApplicationController
  before_action :set_content_pack, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /content_packs
  # GET /content_packs.json
  def index
    @content_packs = ContentPack.all
  end

  # GET /content_packs/1
  # GET /content_packs/1.json
  def show
  end

  # GET /content_packs/new
  def new
    @content_pack = ContentPack.new
    @content_types = ContentType.all
    render :layout => false
  end

  # GET /content_packs/1/edit
  def edit
    if @content_pack.empty?
      @content_types = ContentType.all
    end
    render :layout => false
  end

  # POST /content_packs
  # POST /content_packs.json
  def create
    @content_pack = ContentPack.new(content_pack_params)
    @content_pack.user = current_user
    respond_to do |format|
      if @content_pack.save
        @content_packs = ContentPack.all
      else
        @content_types = ContentType.all
      end
      format.js
    end
  end

  # PATCH/PUT /content_packs/1
  # PATCH/PUT /content_packs/1.json
  def update
    respond_to do |format|
      if !@content_pack.published? && @content_pack.update(content_pack_params)
        @content_packs = ContentPack.all
      elsif @content_pack.empty?
        @content_types = ContentType.all
      end
      format.js
    end
  end

  # DELETE /content_packs/1
  # DELETE /content_packs/1.json
  def destroy
    if @content_pack.destroy
      render json: {success: true}
    else
      render json: @content_pack.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_pack
      @content_pack = ContentPack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_pack_params
      params.require(:content_pack).permit(:name, :description, :content_type_id)
    end

end
