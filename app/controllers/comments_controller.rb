class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    @record = Record.find(params[:id])
    redirect_to record_path(@record)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,record_id: params[:record_id])
  end
end
