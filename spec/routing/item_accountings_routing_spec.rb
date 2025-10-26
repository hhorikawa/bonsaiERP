require "rails_helper"

RSpec.describe ItemAccountingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/item_accountings").to route_to("item_accountings#index")
    end

    it "routes to #new" do
      expect(get: "/item_accountings/new").to route_to("item_accountings#new")
    end

    it "routes to #show" do
      expect(get: "/item_accountings/1").to route_to("item_accountings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/item_accountings/1/edit").to route_to("item_accountings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/item_accountings").to route_to("item_accountings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/item_accountings/1").to route_to("item_accountings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/item_accountings/1").to route_to("item_accountings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/item_accountings/1").to route_to("item_accountings#destroy", id: "1")
    end
  end
end
