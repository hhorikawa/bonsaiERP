require "rails_helper"

RSpec.describe ContactAccountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/contact_accounts").to route_to("contact_accounts#index")
    end

    it "routes to #new" do
      expect(get: "/contact_accounts/new").to route_to("contact_accounts#new")
    end

    it "routes to #show" do
      expect(get: "/contact_accounts/1").to route_to("contact_accounts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/contact_accounts/1/edit").to route_to("contact_accounts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/contact_accounts").to route_to("contact_accounts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/contact_accounts/1").to route_to("contact_accounts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/contact_accounts/1").to route_to("contact_accounts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/contact_accounts/1").to route_to("contact_accounts#destroy", id: "1")
    end
  end
end
