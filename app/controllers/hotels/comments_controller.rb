class Hotels::CommentsController < ApplicationController
  before_action :set_commentable

  include Commentable

  private

  def after_create_path
    hotel_path(@commentable, @commentable)
  end

  def set_commentable
    @commentable = Hotel.find_by(slug: params[:hotel_id])
  end
end
