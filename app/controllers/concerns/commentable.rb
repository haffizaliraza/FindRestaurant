module Commentable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def create
    if comment.save
      redirect_to after_create_path
    else
      render "comments/handle_error", status: :unprocessable_entity
    end
  end

  private

  def comment
    @comment = @commentable.comments.new(comment_params)
  end

  def comment_params
    permitted_params = params.require(:comment).permit(:content)
    permitted_params[:user_id] = current_user.id
    permitted_params[:parent_id] = @parent&.id

    permitted_params
  end
end
