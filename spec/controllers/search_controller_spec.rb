require 'spec_helper'

describe SearchController do

  describe "GET 'query'" do
    it "returns http success" do
      get 'query'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'generate'" do
    it "returns http success" do
      get 'generate'
      response.should be_success
    end
  end

end
