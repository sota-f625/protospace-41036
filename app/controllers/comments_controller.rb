class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = @prototype.comments.includes(:user)  # コメント一覧を取得する
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end