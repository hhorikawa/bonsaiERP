require 'rails_helper'

RSpec.describe "transfer_requests/edit", type: :view do
  let(:transfer_request) {
    TransferRequest.create!()
  }

  before(:each) do
    assign(:transfer_request, transfer_request)
  end

  it "renders the edit transfer_request form" do
    render

    assert_select "form[action=?][method=?]", transfer_request_path(transfer_request), "post" do
    end
  end
end
