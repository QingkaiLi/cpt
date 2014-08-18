require 'spec_helper'

describe TopicsController do

  before(:each) do
    @current_user = create(:user)
    session[:user_id] = @current_user.id

   @content_pack = create(:content_pack)
   @topic = create(:topic, content_pack_id: @content_pack.id)
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, content_pack_id: @topic.content_pack.id
      expect(response.status).to eq(200)
    end

    it "assigns @topics" do
      get :index, content_pack_id: @topic.content_pack.id
      assigns(:topics).should include(@topic)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, content_pack_id: @topic.content_pack.id
      expect(response.status).to eq(200)
    end

    it "assigns a new topic to @topic" do
      get :new, content_pack_id: @topic.content_pack.id
      assigns(:topic).id.should be_nil
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      get :edit, id: @topic
      expect(response.status).to eq(200)
    end

    it "assigns the requested topic to @topic" do
      get :edit, id: @topic
      assigns(:topic).should eq(@topic)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "saves the new topic in the database" do
        expect{
          post :create, :format => :js, content_pack_id: @topic.content_pack_id, topic: build(:topic).attributes.merge(content_pack_id: @topic.content_pack_id)
        }.to change(Topic, :count).by(2)
      end

      describe "create first topic" do
        it "selections will be moved to first topic automatically" do
          @cp = create(:content_pack)
          s = create :selection, topic: @cp.default_topic
          s.topic.default.should be_true
          post :create, :format => :js, content_pack_id: @cp.id, topic: build(:topic).attributes.merge(content_pack_id: @cp.id)
          s.reload.topic.default.should be_false
          assigns(:topic).should eq s.topic
        end
      end

      it "responds successfully with an HTTP 200 status code" do
        post :create, :format => :js, content_pack_id: @topic.content_pack_id, topic: build(:topic).attributes.merge(content_pack_id: @topic.content_pack_id)
        expect(response.status).to eq(200)
        assigns(:topic).default.should be_false
      end
    end

    context "with invalid attributes" do
      it "does not save the new topic in the database" do
        expect{
          post :create, :format => :js, content_pack_id: @topic.content_pack_id, topic: attributes_for(:topic, name: "", content_pack_id: @topic.content_pack_id)
        }.to_not change(Topic, :count)
      end
    end

  end

  describe "PUT update" do
    before(:each) do
      @topic = create(:topic, name: "test", grade_level: 2.5)
    end

    context "with valid attributes" do
      it "update requested topic in the database" do
        put :update, :format => :js, id: @topic, topic: build(:topic, name: "test2", grade_level: 2.8).attributes
        @topic.reload
        @topic.name.should eq("test2")
        @topic.grade_level.should == '2.8'
      end
    end

    context "with invalid attributes" do
      it "does not save the requested topic in the database" do
        put :update, :format => :js, id: @topic, topic: build(:topic, name:"", grade_level: "hello").attributes
        @topic.reload
        @topic.name.should eq("test")
        @topic.grade_level.should == '2.5'
      end
    end
  end

  describe "DELETE destroy" do
    it "delete the topic" do
      expect{
        delete :destroy, id: @topic
      }.to change(Topic, :count).by(-1)
    end

    it "responds successfully with an HTTP 200 status code" do
      delete :destroy, id: @topic
      expect(response.status).to eq(200)
    end

    it "delete non empty topic" do
      s = create(:selection, topic: @topic)
      expect{
        delete :destroy, id: @topic
      }.to change(Topic, :count).by(0)
    end

    it "cannot be deleted if content pack has published" do
      @topic.content_pack.status = Status.find_by_name('Published')
      @topic.content_pack.save
      expect{
        delete :destroy, id: @topic
      }.to change(Topic, :count).by(0)
    end
  end


  describe "ordering" do
    before(:each) do
      cp = create(:content_pack)
      @topic1 = create(:topic, name: "test1", grade_level: 2.5, content_pack_id: cp.id)
      @topic2 = create(:topic, name: "test2", grade_level: 2.5, content_pack_id: cp.id)
      @topic3 = create(:topic, name: "test3", grade_level: 2.5, content_pack_id: cp.id)
      @topic4 = create(:topic, name: "test4", grade_level: 2.5, content_pack_id: cp.id)
    end

    it "test ordering" do
        @topic1.priority.should == 1
        @topic2.priority.should == 2
        @topic3.priority.should == 3
        @topic4.priority.should == 4
        post :ordering, id: @topic1, to_priority: @topic3.priority
        @topic1.reload
        @topic2.reload
        @topic3.reload
        @topic4.reload
        @topic1.priority.should == 3
        @topic2.priority.should == 1
        @topic3.priority.should == 2
        @topic4.priority.should == 4
    end
  end
end
