class PostsController < ApplicationController
  before_action :logged_in?, only: [:new]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user[:id]))

    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def logged_in?
    return if user_signed_in?

    redirect_to '/'
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
