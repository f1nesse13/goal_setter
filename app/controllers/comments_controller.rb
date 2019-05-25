class CommentsController < ApplicationController
  def index
    @comments = comment_type
    render :index
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    redirect = params[:user_id] == nil
    if @comment.save
      flash[:notice] = ["Comment saved"]
      if redirect
        redirect_to goal_url(@comment.commentable_id)
      else
        redirect_to user_url(@comment.commentable_id)
      end
    else
      flash[:error] = ["Unable to add comment"]
      redirect_to users_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :author_id)
  end
end
