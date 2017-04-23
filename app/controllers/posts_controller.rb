class PostsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end
  def create
    @post =Post.new(post_params)
    @group = Group.find(params[:group_id])
    @post.group=@group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to account_posts_path, notice:"Update Success"
    else
      render :edit
    end
  end

  def destroy

    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.delete
    flash[:alert]= "POST deleted"
      redirect_to account_posts_path
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
