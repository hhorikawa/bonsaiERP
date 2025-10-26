require 'rails_helper'

RSpec.describe "item_accountings/edit", type: :view do
  let(:item_accounting) {
    ItemAccounting.create!()
  }

  before(:each) do
    assign(:item_accounting, item_accounting)
  end

  it "renders the edit item_accounting form" do
    render

    assert_select "form[action=?][method=?]", item_accounting_path(item_accounting), "post" do
    end
  end
end
