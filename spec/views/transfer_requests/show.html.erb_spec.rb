require 'rails_helper'

RSpec.describe "transfer_requests/show", type: :view do
  before(:each) do
    assign(:transfer_request, TransferRequest.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
