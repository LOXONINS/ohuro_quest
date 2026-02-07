class BathHacksPostsController < ApplicationController
    before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @bath_hacks_posts = BathHacksPost.includes(:user).order(created_at: :desc)
  end

  def new
    @bath_hacks_post = BathHacksPost.new
  end

  def create
    @bath_hacks_post = current_user.bath_hacks_posts.build(bath_hacks_post_params)
    if @bath_hacks_post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to bath_hacks_posts_path
    else
      flash.now[:alert] = "投稿できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @bath_hacks_post = BathHacksPost.find(params[:id])
  end

  private

  def bath_hacks_post_params
    params.require(:bath_hacks_post).permit(:title, :content)
  end
end
