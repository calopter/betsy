require "test_helper"

describe CategoryController do
    describe "index action" do
      
      it "gives back a successful response" do
        get category_path
        must_respond_with :success
      end
      
      it "returns with a success if there are no categories available" do
        get category_path
        must_respond_with :success
      end
    end
  end