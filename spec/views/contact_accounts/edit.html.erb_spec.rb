require 'rails_helper'

RSpec.describe "contact_accounts/edit", type: :view do
  let(:contact_account) {
    ContactAccount.create!()
  }

  before(:each) do
    assign(:contact_account, contact_account)
  end

  it "renders the edit contact_account form" do
    render

    assert_select "form[action=?][method=?]", contact_account_path(contact_account), "post" do
    end
  end
end
