class PostsController < ApplicationController
  include AuthenticateUser

  # GET /posts
  def index
    posts = Post.all
    render json: posts, each_serializer: PostSerializer
  end

  # GET /posts/:id
  def show
    post = Post.find(params[:id])
    render json: post, serializer: PostDetailsSerializer
    # render json: post, include: :comments

  end

  # POST /create-post
  def create
    post = current_user.posts.build(post_params)

    if post.save
      render json: post, status: :created, serializer: PostDetailsSerializer
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end



  # PATCH /edit-post/:id
  def update
    post = current_user.posts.find(params[:id])

    if post.update(post_params)
      render json: post
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /delete-post/:id
  def destroy
    post = current_user.posts.find(params[:id])
    if post.destroy
      render json: { message: 'Post deleted successfully' }
    else
      render json: { error: 'Failed to delete post' }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, tags: [])
  end
end
