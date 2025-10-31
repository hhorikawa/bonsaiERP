require 'rails_helper'

RSpec.describe "transfer_requests/new", type: :view do
  before(:each) do
    assign(:transfer_request, TransferRequest.new())
  end

  it "renders new transfer_request form" do
    render

    assert_select "form[action=?][method=?]", transfer_requests_path, "post" do
    end
  end
end
