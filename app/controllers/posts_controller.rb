class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post has been created"
      redirect_to posts_path
    else
      flash.now[:alert] = "Post could not be created! Please check the form"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated"
      redirect_to(post_path(@post))
    else
      flash.now[:alert] = "Failed to update post. Please check the form"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to posts_path
    else
      flash.now[:alert] = "Failed to delete!"
      render :edit
    end
  end


  private
  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
