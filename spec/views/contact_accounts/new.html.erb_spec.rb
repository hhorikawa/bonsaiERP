require 'rails_helper'

RSpec.describe "contact_accounts/new", type: :view do
  before(:each) do
    assign(:contact_account, ContactAccount.new())
  end

  it "renders new contact_account form" do
    render

    assert_select "form[action=?][method=?]", contact_accounts_path, "post" do
    end
  end
end
