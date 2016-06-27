class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(idea: idea, user: current_user)
    if like.save
      redirect_to idea_path(idea), notice: "Liked!"
    else
      redirect_to idea_path(idea), alert: "Can't Like!"
    end
  end

  def destroy
    like = current.user.likes.find params[:id]
    like.destroy
    redirect_to post, notice: "Unliked"
  end
end
