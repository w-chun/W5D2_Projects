class PostsController < ApplicationController
  before_action :require_logged_in

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find{params[:id]}
  end

  def show
    @post = Post.find{params[:id]}
  end

  def update
    @post = Post.find{params[:id]}
    if @post.update_attributes(post_params)
      redirect_to sub_url(@post.subs)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      redirect_to post_url(@post)
      flash[:errors] = @post.errors.full_messages
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
