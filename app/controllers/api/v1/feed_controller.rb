class Api::V1::FeedController < ApplicationController
  def index
    @feed = Post.where(user_id: params[:id])
    render json: @feed
  end
end
