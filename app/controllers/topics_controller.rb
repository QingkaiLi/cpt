class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :ordering]
  before_action :authorize

  # GET /topics/id
  # GET /topics.json
  def index
    @content_pack = ContentPack.find(params[:content_pack_id])
    @topics = @content_pack.topics
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new/1
  # params[:id] is content pack id
  def new
    @topic = Topic.new
    @topic.content_pack_id = params[:content_pack_id]
    @content_pack = ContentPack.find(params[:content_pack_id])
    render :layout => false
  end

  # GET /topics/1/edit
  def edit
    render :layout => false
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @content_pack = ContentPack.find(params[:content_pack_id])
    respond_to do |format|
      if @topic.save
        @topics = @content_pack.topics
      end
      format.js
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        @content_pack = @topic.content_pack
        @topics = @content_pack.topics
      end
      format.js
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    if @topic.destroy
      render json: {success: true}
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # POST /topics/1
  # POST /topics/1.json
  def ordering
    @topic.ordering(params[:to_priority].to_i)
    render nothing:true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :grade_level, :content_pack_id)
    end
end
