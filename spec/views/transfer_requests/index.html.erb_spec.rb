require 'rails_helper'

RSpec.describe "transfer_requests/index", type: :view do
  before(:each) do
    assign(:transfer_requests, [
      TransferRequest.create!(),
      TransferRequest.create!()
    ])
  end

  it "renders a list of transfer_requests" do
    render
    cell_selector = 'div>p'
  end
end
