class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def index
       @posts = Post.all
    end

    def show
       @post = Post.find(params[:id])
    end

    def new
      @post = current_user.posts.build
    end

    def create
      @post = current_user.posts.build(post_params)

              if @post.save
                  flash[:success] = "Your post has been created!"
                  redirect_to posts_path
              else
                  flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
                  render :new
              end
          
    end

    def edit
    end

    def update
      if @post.update(post_params)
        flash[:success] = "Post updated."
        redirect_to posts_path
      else
        flash.now[:alert] = "Update failed. Please check the form."
        render :edit
      end
    end

    def destroy
      @post.destroy
      flash[:success] = "Post succesfully deleted."
      redirect_to posts_path
    end

    private

    def post_params
      params.require(:post).permit(:image, :caption, :name)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path
  end
end
