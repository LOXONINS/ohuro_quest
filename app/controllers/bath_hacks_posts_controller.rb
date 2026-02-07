class BathHacksPostsController < ApplicationController
    before_action :authenticate_user!, except: [ :index, :show ]
    before_action :correct_user, only: [ :edit, :update, :destroy ]

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

  def edit
    @bath_hacks_post = current_user.bath_hacks_posts.find(params[:id])
  end

  def update
    @bath_hacks_post = current_user.bath_hacks_posts.find(params[:id])
    if @bath_hacks_post.update(bath_hacks_post_params)
      flash[:notice] = "投稿に成功しました"
      redirect_to bath_hacks_posts_path
    else
      flash.now[:alert] = "投稿できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    bath_hacks_post = current_user.bath_hacks_posts.find(params[:id])
    bath_hacks_post.destroy!
    redirect_to bath_hacks_posts_path, success: "削除しました", status: :see_other
  end

  private

  def bath_hacks_post_params
    params.require(:bath_hacks_post).permit(:title, :content)
  end

  def correct_user
    @bath_hacks_post = BathHacksPost.find(params[:id])
    @user = @bath_hacks_post.user
    redirect_to bath_hacks_posts_path, alert: "権限がありません" unless @bath_hacks_post.user == current_user
  end
end
