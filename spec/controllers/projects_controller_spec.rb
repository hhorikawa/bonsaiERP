require 'spec_helper'

describe ProjectsController do
  before(:each) do
    stub_auth_and_tenant
    # Stub format.html to avoid template errors
    allow(controller).to receive(:render)
    allow(controller).to receive(:redirect_to).and_return(true)
  end

  def mock_project(stubs={})
    (@mock_project ||= instance_double(Project).as_null_object).tap do |project|
      project.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      allow(Project).to receive_message_chain(:page).and_return([mock_project])
      get :index, format: :json
      assigns(:projects).should eq([mock_project])
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      allow(Project).to receive(:find).with("37").and_return(mock_project)
      get :show, params: { id: "37" }, format: :json
      assigns(:project).should be(mock_project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      allow(Project).to receive(:new).with(active: true).and_return(mock_project)
      get :new, format: :json
      assigns(:project).should be(mock_project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      allow(Project).to receive(:find).with("37").and_return(mock_project)
      get :edit, params: { id: "37" }, format: :json
      assigns(:project).should be(mock_project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created project as @project" do
        allow(Project).to receive(:new).and_return(mock_project(save: true))
        post :create, params: { project: { 'name' => 'Test Project' } }, format: :json
        assigns(:project).should be(mock_project)
      end

      it "redirects to the created project" do
        allow(Project).to receive(:new).and_return(mock_project(save: true))
        allow(controller).to receive(:redirect_ajax)
        post :create, params: { project: { 'name' => 'Test Project' } }, format: :json
        expect(controller).to have_received(:redirect_ajax).with(mock_project, notice: 'El project fue creado.')
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        allow(Project).to receive(:new).and_return(mock_project(save: false))
        post :create, params: { project: { 'name' => 'Test Project' } }, format: :json
        assigns(:project).should be(mock_project)
      end

      it "re-renders the 'new' template" do
        allow(Project).to receive(:new).and_return(mock_project(save: false))
        # Stub render to avoid template missing error
        allow(controller).to receive(:render).with("new")
        post :create, params: { project: { 'name' => 'Test Project' } }, format: :json
        expect(controller).to have_received(:render).with("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        allow(Project).to receive(:find).with("37").and_return(mock_project)
        expect(mock_project).to receive(:update)
        put :update, params: { id: "37", project: { 'name' => 'Test Project' } }, format: :json
      end

      it "assigns the requested project as @project" do
        allow(Project).to receive(:find).with("1").and_return(mock_project(update: true))
        put :update, params: { id: "1", project: { 'name' => 'Test Project' } }, format: :json
        assigns(:project).should be(mock_project)
      end

      it "redirects to the project" do
        allow(Project).to receive(:find).with("1").and_return(mock_project(update: true))
        # Stub redirect_to to avoid routing errors
        allow(controller).to receive(:redirect_to).with(mock_project, notice: 'El project fue actualizado.')
        put :update, params: { id: "1", project: { 'name' => 'Test Project' } }, format: :json
        expect(controller).to have_received(:redirect_to).with(mock_project, notice: 'El project fue actualizado.')
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        allow(Project).to receive(:find).with("1").and_return(mock_project(update: false))
        put :update, params: { id: "1", project: { 'name' => 'Test Project' } }, format: :json
        assigns(:project).should be(mock_project)
      end

      it "re-renders the 'edit' template" do
        allow(Project).to receive(:find).with("1").and_return(mock_project(update: false))
        # Stub render to avoid template missing error
        allow(controller).to receive(:render).with(action: "edit")
        put :update, params: { id: "1", project: { 'name' => 'Test Project' } }, format: :json
        expect(controller).to have_received(:render).with(action: "edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      allow(Project).to receive(:find).with("37").and_return(mock_project)
      expect(mock_project).to receive(:destroy)
      allow(controller).to receive(:redirect_ajax)
      delete :destroy, params: { id: "37" }, format: :json
    end

    it "redirects to the projects list" do
      allow(Project).to receive(:find).with("1").and_return(mock_project)
      allow(controller).to receive(:redirect_ajax)
      delete :destroy, params: { id: "1" }, format: :json
      expect(controller).to have_received(:redirect_ajax).with(mock_project)
    end
  end
end
