class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  before_action :current_user

  def index
    @posts = Post.all.order("updated_at desc")
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    # @post = Post.new(post_params)
    # @post.user_id = current_user.id
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "On a créé un blog !"
      else
        render :new
      end
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "J'ai modifié le blog !"
    else
      render :edit
    end
  end
  

  def destroy
    @post.destroy
    redirect_to posts_path, notice:"J'ai supprimé le blog !"
  end

  def confirm
    # @post = Post.new(post_params)
    # @post.user_id = current_user.id
    @post = current_user.posts.build(post_params)
    # binding.pry
    render :new if @post.invalid?
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
