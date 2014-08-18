class SelectionsController < ApplicationController
  before_action :set_selection, only: [:show, :edit, :update, :destroy, :ordering, :move, :copy]
  before_action :set_content_pack, only: [:new, :edit, :create, :update, :destroy, :move_copy]
  before_action :authorize

  # GET /selections
  # GET /selections.json
  def index
    @topic = Topic.find(params[:id])
    @selections = @topic.selections
  end

  # GET /selections/1
  # GET /selections/1.json
  def show
  end

  # GET /selections/new/1
  # params[:id] is content pack id
  def new
    @selection = Selection.new
    render :layout => false
  end

  # GET /selections/1/edit
  def edit
    render :layout => false
  end

  # POST /selections
  # POST /selections.json
  def create
    @selection = Selection.new(selection_params)
    @selection.topic = @content_pack.default_topic
    @selection.updater = current_user
    respond_to do |format|
      if @selection.save
        @topics = @content_pack.topics
      end
      format.js
    end
  end

  # PATCH/PUT /selections/1
  # PATCH/PUT /selections/1.json
  def update
    @selection.updater = current_user
    respond_to do |format|
      if @selection.update selection_params
        @topics = @content_pack.topics
      end
      format.js
    end
  end

  # DELETE /selections/1
  # DELETE /selections/1.json
  def destroy
    if @selection.destroy
      render json: {success: true}
    else
      render json: @selection.errors, status: :unprocessable_entity
    end
  end

  # POST selections/ordering/1.json
  def ordering
    @selection.ordering(params[:to_topic_id], params[:to_priority].to_i)
    render nothing:true
  end

  # GET selections/:id/move_copy
  def move_copy
    @selection = Selection.find(params[:id])
    @content_packs = ContentPack.joins(:status).where.not(id: params[:content_pack_id], statuses: {name: ContentPack::STATUS_PUBLISHED})
    if @content_packs.empty?
      render json: @content_pack.errors, status: :unprocessable_entity
    else
      render 'move_copy', :layout => false
    end
  end

  # POST selections/id/move
  def move
    @content_pack_id = params[:content_pack][:id]
    @selection.move_to(params[:content_pack][:id], params[:title])
  end

  # POST selections/id/copy
  def copy
    @content_pack_id = params[:content_pack][:id]
    @selection = @selection.copy_to(params[:content_pack][:id], params[:title])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selection
      @selection = Selection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def selection_params
      params.require(:selection).permit(:title, :grade_equivalent_level, :lexile_level, :guided_reading_level, :wcpm_target, :internationally,
          :description, :author, :illustrator, :publisher, :intro_text)
    end

    def set_content_pack
      @content_pack = ContentPack.find(params[:content_pack_id])
    end
end

