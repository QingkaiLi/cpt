require 'spec_helper'

describe SelectionsController do
  before(:each) do
    @current_user = create(:user)
    session[:user_id] = @current_user.id
    @content_pack = create(:content_pack)
    @topic = create(:topic, content_pack_id: @content_pack.id)
    @selection = create(:selection, topic: @content_pack.default_topic)
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, id: @topic
      expect(response.status).to eq(200)
    end

    it "assigns @selections" do
      get :index, id: @topic
      assigns(:selections).should eq(@topic.selections)
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @selection
      expect(response.status).to eq(200)
    end

    it "assigns the requested selection to @selection" do
      get :show, id: @selection
      assigns(:selection).should eq(@selection)
    end
  end

  describe "GET #new" do
    it "assigns a new selection to @selection" do
      get :new, content_pack_id: @topic.content_pack_id
      assigns(:selection)
    end

    it "responds successfully with an HTTP 200 status code" do
      get :new, content_pack_id: @topic.content_pack_id
      assigns(:selection)
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      get :edit, id: @selection, content_pack_id: @topic.content_pack_id
      expect(response.status).to eq(200)
    end

    it "assigns the requested selection to @selection" do
      get :edit, id: @selection, content_pack_id: @topic.content_pack_id
      assigns(:selection).should eq(@selection)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "saves the new selection in the database" do
        expect{
          post :create, :format => :js, content_pack_id: @topic.content_pack_id, selection: build(:selection).attributes#.merge(topic_id: @topic.id)
        }.to change(Selection, :count).by(1)
      end

      it "should associate to default topic" do
        post :create, :format => :js, content_pack_id: @content_pack.id, selection: build(:selection).attributes#.merge(topic_id: @topic.id)
        assigns(:selection).topic.should eq(@content_pack.default_topic)
      end

      it "responds successfully with an HTTP 200 status code" do
        post :create, :format => :js, content_pack_id: @topic.content_pack_id, selection: build(:selection).attributes#.merge(topic_id: @topic.id)
        expect(response.status).to eq(200)
      end
    end

    context "with invalid attributes" do
      it "does not save the new selection in the database" do
        expect{
          post :create, :format => :js, content_pack_id: @topic.content_pack_id, selection: build(:selection, title: "").attributes#.merge(topic_id: @topic.id)
        }.to_not change(Selection, :count)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @selection.title = "test"
      @selection.description = "hello test"
      @selection.save
    end

    context "with valid attributes" do
      it "update requested selection in the database" do
        put :update, :format => :js, id: @selection, content_pack_id: @topic.content_pack_id, selection: build(:selection, title: "test", description: "hello").attributes
        @selection.reload
        @selection.title.should eq("test")
        @selection.description.should eq("hello")
      end
      
      it "update user should change to current login user" do
        put :update, :format => :js, id: @selection, content_pack_id: @topic.content_pack_id, selection: build(:selection, title: "test", description: "hello").attributes
        @selection.reload
        @selection.updater.should == @current_user
      end
    end

    context "with invalid attributes" do
      it "does not save the requested selection in the database" do
        put :update, :format => :js, id: @selection, content_pack_id: @topic.content_pack_id, selection: build(:selection, title:"", description: "hello").attributes
        @selection.reload
        @selection.title.should eq("test")
        @selection.description.should eq("hello test")
      end
    end
    
  end

  describe "DELETE destroy" do
    it "delete the selection" do
      expect{
        delete :destroy, id: @selection, content_pack_id: @topic.content_pack_id
      }.to change(Selection, :count).by(-1)
    end

    it "responds successfully with an HTTP 200 status code" do
      delete :destroy, id: @selection, content_pack_id: @topic.content_pack_id
      expect(response.status).to eq(200)
    end
  end

  describe "GET #move_copy" do
    it "responds with an HTTP 422 status code" do
      get :move_copy, id: @selection, content_pack_id: @topic.content_pack_id
      expect(response.status).to eq(422)
    end

    it "responds successfully with an HTTP 200 status code" do
      create(:content_pack)
      get :move_copy, id: @selection, content_pack_id: @topic.content_pack_id
      expect(response.status).to eq(200)
    end

    it "assigns @selection @content_pack and @content_packs" do
      @content_packs = ContentPack.joins(:status).where.not(id: @topic.content_pack_id, statuses: {name: ContentPack::STATUS_PUBLISHED})
      get :move_copy, id: @selection, content_pack_id: @topic.content_pack_id
      assigns(:selection).should eq(@selection)
      assigns(:content_pack).should eq(@content_pack)
      assigns(:content_packs).should eq(@content_packs)
    end
  end

  describe "POST move" do
    before(:each) do
      @cp = create(:content_pack)
    end

    it "responds successfully with an HTTP 200 status code" do
      post :move, content_pack: {id: @cp.id}, id: @selection.id, :format => 'js'
      expect(response.status).to eq(200)
    end

    it "saves the new topic Selection relations in the database" do
      post :move, content_pack: {id: @cp.id}, id: @selection.id, :format => 'js'
      assigns(:selection).topic.should eq(@cp.default_topic)
      assigns(:selection).topic.should_not eq(@content_pack.default_topic)
      assigns(:selection).priority.should == 0
    end

    it "cannot move to the new content pack which already has the same selection" do
      create(:selection, title: @selection.title, topic: @cp.default_topic)
      expect {
        post :move, content_pack: {id: @cp.id}, id: @selection.id, :format => 'js'
      }.to change(Selection, :count).by(0)
    end

    it "successfully move to the new content pack which already has the same selection after renameing selection" do
      create(:selection, title: @selection.title, topic: @cp.default_topic)
      expect {
        post :move, content_pack: {id: @cp.id}, id: @selection.id, title: 'test', :format => 'js'
      }.to change(Selection, :count).by(0)
      assigns(:selection).title.should eq('test')
    end
  end

  describe "POST copy" do
    before(:each) do
      @cp = create(:content_pack)
    end

    it "responds successfully with an HTTP 200 status code" do
      post :copy, content_pack: {id: @cp.id}, id: @selection.id, :format => 'js'
      expect(response.status).to eq(200)
    end

    it "create the new selection in the database" do
      expect{
        post :copy, content_pack: {id: @cp.id}, id: @selection.id, :format => 'js'
      }.to change(Selection, :count).by(1)
    end

    it "cannot copy to the content pack which already has the same selection" do
      create(:selection, title: @selection.title, topic: @cp.default_topic)
      expect{
        post :copy, content_pack: {id: @cp.id}, id: @selection.id, :format => 'js'
      }.to change(Selection, :count).by(0)
    end

    it "successfully copy to the new content pack which already has the same selection after renameing selection" do
      create(:selection, title: @selection.title, topic: @cp.default_topic)
      expect {
        post :copy, content_pack: {id: @cp.id}, id: @selection.id, title: 'test', :format => 'js'
      }.to change(Selection, :count).by(1)
    end
  end

  describe "POST ordering" do
    before(:each) do
      @default_topic = @content_pack.default_topic
      @selection1 = create(:selection, topic: @default_topic)
      @selection2 = create(:selection, topic: @default_topic)
      @selection3 = create(:selection, topic: @default_topic)

      @selection.priority.should == 0
      @selection1.priority.should == 1
      @selection2.priority.should == 2
      @selection3.priority.should == 3
    end

    it "responds successfully with an HTTP 200 status code" do
      post :ordering, content_pack_id: @content_pack.id, id: @selection.id, to_topic_id: @default_topic.id, to_priority: 2
      expect(response.status).to eq(200)
    end

    it "ordering within one topic" do
      post :ordering, content_pack_id: @content_pack.id, id: @selection.id, to_topic_id: @default_topic.id, to_priority: 1
      @selection.reload.priority.should == 1
      @selection1.reload.priority.should == 0
      @selection2.reload.priority.should == 2
      @selection3.reload.priority.should == 3
    end

    it "ordering between two topics" do
      @selection4 = create(:selection, topic: @topic)
      @selection4.priority = 0

      post :ordering, content_pack_id: @content_pack.id, id: @selection4.id, to_topic_id: @default_topic.id, to_priority: 0
      @selection4.reload.priority.should == 0
      @selection.reload.priority.should == 1
      @selection1.reload.priority.should == 2
      @selection2.reload.priority.should == 3
      @selection3.reload.priority.should == 4
    end
  end
end
