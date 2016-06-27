class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_owner, only: [:create, :edit, :destroy, :update]

  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def create
    @idea = Idea.new idea_params
    @idea = Idea.create(idea_params)
    if @idea.save
      redirect_to idea_path(@idea), notice: "Idea Created!"
    else
      flash[:alert] = "Idea not created!"
      render :new
    end
  end

  def show
    @like = @idea.like_for(current_user)
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea), notice: "Idea Updated!"
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path, notice: "Idea Deleted!"
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :body, :avatar)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize_owner
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @question
  end

  def authenticate_user!
    redirect_to new_session_path, alerts: "Please Sign In" unless user_signed_in?
  end
end
