require 'spec_helper'

describe SearchController do

  describe "GET 'query' not authenticated" do
    it "returns http redirect" do
      get 'query'
      response.status.should eq(302)
    end
  end

  describe "GET 'index' not authenticated" do
    it "returns http redirect" do
      get 'index'
      response.status.should eq(302)
    end
  end

end
