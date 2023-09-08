class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update]
  before_action :set_record, only: [:create]

  def create
    comment = Comment.create(comment_params)
    redirect_to record_path(@record)
  end

  def edit
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)

  end
  private
  def comment_params
    params.require(:comment).permit(:text).merge(record_id: params[:record_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  def set_record
    @record = Record.find(params[:record_id])
  end

end
