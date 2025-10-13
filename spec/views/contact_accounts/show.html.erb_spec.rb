require 'rails_helper'

RSpec.describe "contact_accounts/show", type: :view do
  before(:each) do
    assign(:contact_account, ContactAccount.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
