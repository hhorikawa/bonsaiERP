require 'rails_helper'

RSpec.describe "item_accountings/index", type: :view do
  before(:each) do
    assign(:item_accountings, [
      ItemAccounting.create!(),
      ItemAccounting.create!()
    ])
  end

  it "renders a list of item_accountings" do
    render
    cell_selector = 'div>p'
  end
end
