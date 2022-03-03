class Api::V1::FeedController < ApplicationController
  def index
    if current_user
      @feed = Post.where(user_id: current_user.id).order(id: :desc)
      render json: @feed, status: :ok
    end
  end
end
