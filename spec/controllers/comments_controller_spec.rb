require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
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

        it "associates the comment with the idea" do
          valid_request
          expect(Comment.last.idea).to eq(idea)
        end

        it "associates the comment with the logged in user" do
          valid_request
          expect(Comment.last.user).to eq(user)
        end
      end
    end
  end

  describe "#delete" do
    
  end
end
