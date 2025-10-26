require 'rails_helper'

RSpec.describe "item_accountings/show", type: :view do
  before(:each) do
    assign(:item_accounting, ItemAccounting.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
