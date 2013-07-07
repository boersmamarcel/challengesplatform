require_relative '../spec_helper'
describe MessagesController do
	include Devise::TestHelpers

	before (:each) do
		@user = FactoryGirl.create(:user)
		@user2 = FactoryGirl.create(:user, :firstname => "John", :lastname => "Ivy", :email => "j.i@student.utwente.nl")
		sign_in @user
	end
	
	describe "autocomplete" do
		it "should return a json with all users" do
			get :autosuggest, {:term => "John Ivy"}
			response.body.should include(@user2.decorate.fullname)
		end
	end

	it "should render nothing when compose is not an ajax request" do
		get :compose
		response.body.should be_blank
	end

end