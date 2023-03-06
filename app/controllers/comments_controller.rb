# class CommentsController < ApplicationController
#   def create
#     @comment = Comment.new
#     @comment = Comment.new(text: params[:comment][:text], author_id: current_user.id, post_id: params[:post_id])

#     if @comment.save
#       redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
#     else
#       render 'posts/show'
#     end
#   end

#   private

#   def comment_params
#     params.require(:comment).permit(:text)
#   end
# end

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.author = current_user

    if @comment.save
      redirect_to "/users/#{current_user.id}/comments", notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
