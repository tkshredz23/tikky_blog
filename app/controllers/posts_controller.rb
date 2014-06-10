class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:new, :create, :destroy]

  def index
    user = User.find(params[:user_id])
    if user
      @posts = user.posts
    else
      render_404
    end
  end

  def show
    @post = Post.find(params[:id])
    unless @post
      render_404
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to user_posts_path(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit!.merge(user_id: current_user.id)
  end
end
