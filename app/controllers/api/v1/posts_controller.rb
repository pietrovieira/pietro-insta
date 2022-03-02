class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.where(user_id: current_user.id)

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id # i think easy to solve the problem but i dont secure of the resolution.
    if @post.save
      uploads = Cloudinary::Uploader.upload(params[:photo])
      @photo = Photo.new({
          :post_id => @post.id,
          :asset_id => uploads['asset_id'],
          :public_id => uploads['public_id'], 
          :version => uploads['version'], 
          :version_id => uploads['version_id'], 
          :signature => uploads['signature'], 
          :width => uploads['width'], 
          :height => uploads['height'], 
          :format => uploads['format'], 
          :resource_type => uploads['resource_type'], 
          :tags => uploads['tags'], 
          :bytes => uploads['bytes'], 
          :etag => uploads['etag'], 
          :placeholder => uploads['placeholder'], 
          :url => uploads['url'], 
          :secure_url => uploads['secure_url'], 
          :api_key => uploads['api_key'], 
      })
      puts "uploadsuploadsuploadsuploads: #{@photo}"
      @photo.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    begin
      if @post.destroy
        render json: @post, status: :ok
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    rescue
      render json: {}, status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :photo)
    end
end
