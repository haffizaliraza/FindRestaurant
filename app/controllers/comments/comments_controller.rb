class Comments::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable

  private

  def after_create_path
    hotel_path(@commentable, @commentable)
  end

  def set_commentable
    @parent = Comment.find(params[:comment_id])
    @commentable = @parent.commentable
  end
end
