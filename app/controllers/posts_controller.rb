class PostsController < ApplicationController
 before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
 before_action :authenticate_user!, except: [:index, :show, :search]

 def search
  if params[:search].present?
   @posts = Post.friendly.search(params[:search])
  else
   @posts = Post.friendly.all
  end
 end 

 def index
  @posts = Post.friendly.all.order('created_at desc').paginate(:page => params[:page], :per_page => 12)
 end

 def show
   @comments = Comment.where(post_id: @post)
   @random_post = Post.friendly.where.not(id: @post).order("RAND()").first
 end

 def new
  @post = current_user.posts.build
 end

 def create
  @post = current_user.posts.build post_params
  if @post.save
   redirect_to @post
  else
   render 'new'
  end
 end

 def edit
 end

 def update
  if @post.update post_params
   redirect_to @post
  else
   render 'edit'
  end
 end

 def destroy
  @post.destroy
  redirect_to root_path
 end

 def upvote
  @post.upvote_by current_user
  redirect_to :back
 end

 def downvote
  @post.downvote_by current_user
  redirect_to :back
 end


 private
 def find_post
    @post=Post.friendly.find(params[:id])
 end

 def post_params
  params.require(:post).permit(:title, :image, :description, :link, :country, :city, :slug)
 end

end
