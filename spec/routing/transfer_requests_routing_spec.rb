require "rails_helper"

RSpec.describe TransferRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/transfer_requests").to route_to("transfer_requests#index")
    end

    it "routes to #new" do
      expect(get: "/transfer_requests/new").to route_to("transfer_requests#new")
    end

    it "routes to #show" do
      expect(get: "/transfer_requests/1").to route_to("transfer_requests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/transfer_requests/1/edit").to route_to("transfer_requests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/transfer_requests").to route_to("transfer_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/transfer_requests/1").to route_to("transfer_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/transfer_requests/1").to route_to("transfer_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/transfer_requests/1").to route_to("transfer_requests#destroy", id: "1")
    end
  end
end
