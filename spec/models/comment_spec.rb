require_relative '../spec_helper'

describe Comment do 
	it "should not accept comments with less than 3 characters" do
		Comment.create(:comment => "a", :user_id => 1, :challenge_id => 1).should have(1).error_on(:comment)
	end

	it "should not accept comments without user id" do
		Comment.create(:comment => "This is a test comment", :challenge_id => 1).should have(1).error_on(:user_id)
	end

	it "should not accept comments without challenge id" do
		Comment.create(:comment =>  "This is a test comment", :user_id => 1).should have(1).error_on(:challenge_id)
	end

	it "should accept comments with enough characters and an user and an challenge" do
		Comment.create(:comment =>  "This is a test comment", :user_id => 1, :challenge_id => 1).should have(:no).errors_on(:comment)
		Comment.create(:comment =>  "This is a test comment", :user_id => 1, :challenge_id => 1).should have(:no).errors_on(:user_id)
		Comment.create(:comment =>  "This is a test comment", :user_id => 1, :challenge_id => 1).should have(:no).errors_on(:challenge_id)
	end
end