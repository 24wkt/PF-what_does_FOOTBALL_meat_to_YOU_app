class Public::BlogsController < ApplicationController

  before_action :authenticate_end_user!

  def new
    @blog = Blog.new
    # サイドバーに関する定義
    @end_user = current_end_user
    @tags = Tag.all
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.end_user_id = current_end_user.id
    tag_list = params[:blog][:tag_name].split(nil)
    if @blog.save
      @blog.save_tag(tag_list)
      redirect_to blog_path(@blog)
    else
      @end_user = current_end_user
      @tags = Tag.all
      render :new
    end
  end

  def index
    @blogs = Blog.all
    # サイドバーに関する定義
    @end_user = current_end_user
    @tags = Tag.all
  end

  def show
    @blog = Blog.find(params[:id])
    @blog_tags = @blog.tags
    @comment = Comment.new
    # サイドバーに関する定義
    @end_user = current_end_user
    @tags = Tag.all
  end

  def edit
    @blog = Blog.find(params[:id])
    if @blog.end_user == current_end_user
      # サイドバーに関する定義
      @end_user = current_end_user
      @tags = Tag.all
      render "edit"
    else
      redirect_to end_users_home_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to end_user_path(current_end_user)
  end

  def search
    @tag = Tag.find(params[:tag_id])
    @blogs = @tag.blogs.all
    # サイドバーに関する定義
    @end_user = current_end_user
    @tags = Tag.all
  end

  private
    def blog_params
      params.require(:blog).permit(:blog_image, :title, :body)
    end
end
