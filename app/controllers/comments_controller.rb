class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:new, :create, :destroy]

  def show
    #TODO (for comments on the fly)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    @post = Post.find(@comment.post_id)
    redirect_to user_post_path(@post.user, @post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to url_for(:controller => :posts, :action => :show)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params["post_id"])
  end
end