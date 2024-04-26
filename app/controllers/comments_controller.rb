class CommentsController < ApplicationController
  before_action :fetch_comment

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to commentable_path, notice: 'Comment Updated Successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to commentable_path, notic: 'Comment Deleted Successfully!'
    else
      redirect_to commentable_path, alert: 'Error in Comment Deleting!'
    end
  end

  private

  def commentable_path
    hotel_path(@comment.commentable)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def fetch_comment
    @comment = current_user.comments.find(params[:id])
  end
end
