class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(text: params[:comment][:text], author_id: current_user.id, post_id: params[:post_id])

    if @comment.save
      redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
