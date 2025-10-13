require 'rails_helper'

RSpec.describe "contact_accounts/index", type: :view do
  before(:each) do
    assign(:contact_accounts, [
      ContactAccount.create!(),
      ContactAccount.create!()
    ])
  end

  it "renders a list of contact_accounts" do
    render
    cell_selector = 'div>p'
  end
end
