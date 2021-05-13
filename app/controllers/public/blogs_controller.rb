class Public::BlogsController < ApplicationController

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.end_user_id = current_end_user.id
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :new
    end
  end

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
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

  private
    def blog_params
      params.require(:blog).permit(:blog_image, :title, :body)
    end
end
