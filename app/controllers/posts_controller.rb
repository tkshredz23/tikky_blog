class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit!.merge(user_id: current_user.id)
  end
end
