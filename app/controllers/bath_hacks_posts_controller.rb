class BathHacksPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index]

  def index
    @bath_hacks_posts = BathHacksPost.includes(:user).order(created_at: :desc)
  end

  def new
    @bath_hacks_post = BathHacksPost.new
  end

  def create
	@bath_hacks_posts = current_user.bath_hacks_posts.build(bath_hacks_post_params)
	if @bath_hacks_posts.save
		redirect_to bath_hacks_posts_path, success: "投稿できました"
	else
		flash.now[:alart] = "投稿できませんでした"
		render :new, status: :unprocessable_entity
	end
  end

  private

  def bath_hacks_post_params
    params.require(:bath_hacks_post).permit(:title, :content)
  end
end
