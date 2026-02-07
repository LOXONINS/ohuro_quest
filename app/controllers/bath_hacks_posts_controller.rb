class BathHacksPostsController < ApplicationController

  def index
    @bath_hacks_posts = BathHacksPost.includes(:user).order(created_at: :desc)
  end
end
