class BathHacksPostsController < ApplicationController

  def index
    @bath_hacks_posts = BathHacksPost.includes(:user).order(created_at: :desc)
  end

  def new
    @bath_hacks_post = BathHacksPost.new
  end
end
