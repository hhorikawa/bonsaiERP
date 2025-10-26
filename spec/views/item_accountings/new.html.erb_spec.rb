require 'rails_helper'

RSpec.describe "item_accountings/new", type: :view do
  before(:each) do
    assign(:item_accounting, ItemAccounting.new())
  end

  it "renders new item_accounting form" do
    render

    assert_select "form[action=?][method=?]", item_accountings_path, "post" do
    end
  end
end
