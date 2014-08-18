require 'spec_helper'

describe ContentPacksController do
  before(:each) do
    @current_user = create(:user)
    session[:user_id] = @current_user.id
    @content_pack = create(:content_pack)
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @content_packs" do
      get :index
      assigns(:content_packs).should eq([@content_pack])
    end
  end

  describe "GET #new" do
    it "assigns a new content_pack to @content_pack" do
      get :new
      assigns(:content_pack)
    end

    it "responds successfully with an HTTP 200 status code" do
      get :new
      assigns(:content_pack)
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      get :edit, id: @content_pack
      expect(response.status).to eq(200)
    end

    it "assigns the requested content_pack to @content_pack" do
      get :edit, id: @content_pack
      assigns(:content_pack).should eq(@content_pack)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "saves the new content_pack in the database" do
        expect{
          post :create, :format => :js, content_pack: build(:content_pack).attributes
        }.to change(ContentPack, :count).by(1)
      end

      it "responds successfully with an HTTP 200 status code" do
        post :create, :format => :js, content_pack: build(:content_pack).attributes
        expect(response.status).to eq(200)
      end
    end

    context "with invalid attributes" do
      it "does not save the new content_pack in the database" do
        expect{
          post :create, :format => :js, content_pack: build(:invalid_content_pack).attributes
        }.to_not change(ContentPack, :count)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @content_pack = create(:content_pack, name: "test", description: "hello test")
    end

    context "with valid attributes" do
      it "update requested content_pack in the database" do
        put :update, :format => :js, id: @content_pack, content_pack: build(:content_pack, name: "test", description: "hello").attributes
        @content_pack.reload
        @content_pack.name.should eq("test")
        @content_pack.description.should eq("hello")
      end
    end

    context "with invalid attributes" do
      it "does not save the requested content_pack in the database" do
        put :update, :format => :js, id: @content_pack, content_pack: build(:content_pack, name:"", description: "hello").attributes
        @content_pack.reload
        @content_pack.name.should eq("test")
        @content_pack.description.should eq("hello test")
      end
    end

    it "cannot be updated if content_pack has published" do
      content_pack = create(:published_content_pack, name:'test1')
      put :update, :format => :js, id: content_pack, content_pack: build(:published_content_pack, name:'test2').attributes
      content_pack.published?.should be_true
      content_pack.reload
      content_pack.name.should eq("test1")
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @content_pack = create(:content_pack, name: "test1", description: "hello test")
    end

    it "delete the content_pack" do
      expect{
        delete :destroy, id: @content_pack
      }.to change(ContentPack, :count).by(-1)
    end

    it "responds successfully with an HTTP 200 status code" do
      delete :destroy, id: @content_pack
      expect(response.status).to eq(200)
    end

    it "can not be destroyed if content_pack is non empty" do
      create(:selection, topic: @content_pack.default_topic)
      @content_pack.should_not be_empty
      expect{
        delete :destroy, id: @content_pack
      }.to change(ContentPack, :count).by(0)
    end
  end
end
