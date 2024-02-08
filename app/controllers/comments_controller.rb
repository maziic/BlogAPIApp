class CommentsController < ApplicationController
    include AuthenticateUser
  
    # POST /add-comment/:post_id
    def create
      post = Post.find(params[:post_id])
      comment = post.comments.build(comment_params)
      comment.author_id = current_user.id
  
      if comment.save
        render json: comment, status: :created
      else
        render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH /edit-comment/:id
    def update
      comment = current_user.comments.find(params[:id])
  
      if comment.update(comment_params)
        render json: comment
      else
        render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /delete-comment/:id
    def destroy
      comment = current_user.comments.find(params[:id])
      comment.destroy
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  