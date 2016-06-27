require 'rails_helper'

RSpec.describe Comment, type: :model do
  let (:user) { create(:user)}
  let (:idea) { create(:idea)}

  describe "#create" do
    context "with user signed in" do
      before {request.session[:user_id] = user.id}

      context "with valid request" do
        def valid_request
          post :create, idea_id: idea.id, comment: {body: "Hello World"}
        end

        it "creates the comment in the database" do
          expect {valid_request}.to change {Comment.count}.by(1)
        end

        it "redirects to the idea show page" do
          valid_request
          expect(response).to redirect_to(idea_path(idea))
        end
      end
    end
  end

  describe "#delete"

end
