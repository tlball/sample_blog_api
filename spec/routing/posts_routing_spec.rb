require "spec_helper"

describe PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/posts").should route_to("posts#index")
    end

  end
end
