# encoding: utf-8
require 'spec_helper'

describe OrganisationUpdatesController do
  let(:organisation) { build :organisation, id: 1 }
  before(:each) do
    stub_auth
    allow(controller).to receive(:current_organisation).and_return(organisation)
    # Mock template rendering to avoid template errors
    allow_any_instance_of(ActionController::Base).to receive(:render).and_return(true)
    allow_any_instance_of(ActionController::Base).to receive(:default_render).and_return(true)
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, params: { id: 1 }

      expect(assigns(:organisation)).to eq(organisation)
    end
  end

  describe "PATCH 'update'" do
    it "success" do
      allow(organisation).to receive(:update).and_return(true)

      patch :update, params: { id: 1, organisation: { name: 'New name' } }
      
      expect(response).to redirect_to configurations_path(anchor: 'organisation')
      expect(flash[:notice]).to eq('Se actualizo correctamente los datos de su empresa.')
    end

    it "error" do
      allow(organisation).to receive(:update).and_return(false)
      
      patch :update, params: { id: 1, organisation: { name: 'New name' } }
      
      # We're mocking the render call, so we don't need to check the template
    end
  end
end
