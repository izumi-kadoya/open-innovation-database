class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update]

  def create
    comment = Comment.create(comment_params)
    @record = Record.find(params[:id])
    redirect_to record_path(@record)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)

  end
  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,record_id: params[:record_id])
  end

  def set_comment
   @comment = Comment.find(params[:id])
  end

end
