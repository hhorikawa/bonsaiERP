require 'spec_helper'

describe ExpensesController do
  before(:each) do
    stub_auth
    allow(controller).to receive(:currency).and_return('BOB')
    # Mock current_user for controller
    @user = build(:user, id: 10)
    allow(controller).to receive(:current_user).and_return(@user)
    # Mock template rendering to avoid template errors
    allow_any_instance_of(ActionController::Base).to receive(:render).and_return(true)
    allow_any_instance_of(ActionController::Base).to receive(:default_render).and_return(true)
  end

  describe "POST /expenses" do
    let(:expense) do
      inc = build(:expense, id: 1, ref_number: 'E-0001')
      allow(inc).to receive(:persisted?).and_return(true)
      allow(inc).to receive(:to_param).and_return('1-E-0001')
      inc
    end

    before(:each) do
      allow_any_instance_of(Expenses::Form).to receive(:expense).and_return(expense)
      allow_any_instance_of(Expenses::Form).to receive(:create).and_return(true)
      allow_any_instance_of(Expenses::Form).to receive(:create_and_approve).and_return(true)
    end

    it "creates_and_approves" do
      post :create, params: { expenses_form: { currency: 'BOB' }, commit_approve: 'Com Save' }

      expect(response).to redirect_to(expense_path('1-E-0001'))
    end
  end

  describe "PATCH /expenses/:id" do
    let(:expense) do
      inc = build(:expense, id: 1, ref_number: 'E-0001')
      allow(inc).to receive(:persisted?).and_return(true)
      allow(inc).to receive(:to_param).and_return('1-E-0001')
      inc
    end

    it "updates" do
      es_form = instance_double(Expenses::Form, expense: expense, update: true)
      allow(Expenses::Form).to receive(:find).and_return(es_form)

      patch :update, params: { id: 1, expenses_form: { currency: 'BOB' } }

      expect(response).to redirect_to(expense_path('1-E-0001'))
      expect(flash[:notice]).to eq('El Egreso fue actualizado!.')
    end

    it "updates_and_approves" do
      es_form = instance_double(Expenses::Form, expense: expense, update_and_approve: true)
      allow(Expenses::Form).to receive(:find).and_return(es_form)

      patch :update, params: { id: 1, commit_approve: 'Save', expenses_form: { currency: 'BOB' } }

      expect(response).to redirect_to(expense_path('1-E-0001'))
      expect(flash[:notice]).to eq('El Egreso fue actualizado!.')
    end
  end
end
