# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    @posts = Post.order(sort_column => sort_direction)
               .page(params[:page])
               .per(9)
    @post = Post.new
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
  @post = Post.new(post_params)
  begin
    prompt = "purpose：あるある事例を紹介したい, situation：#{@post.category}, detail：#{@post.body}, constraints：without subtitles"
    image_key = ChatgptService.download_image(prompt)
    
    if image_key
      blob = ActiveStorage::Blob.find_by(key: image_key)
      @post.image.attach(blob)
      @post.file_name = blob.filename.to_s
    end
  rescue Net::ReadTimeout
    flash.now[:alert] = '画像生成がタイムアウトしました'
    render :new, status: :unprocessable_entity
    return
  end
  
  if @post.image.attached? && @post.save
    redirect_to posts_path, notice: '投稿が作成されました'
  else
    # エラー時にJavaScriptを実行してモーダルを閉じる
    flash.now[:alert] = '投稿に失敗しました'
    render :new, status: :unprocessable_entity
  end
end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました'
  end

  def mechar
    @post = Post.find(params[:id])
    @post.increment!(:mr)
    
    respond_to do |format|
      format.turbo_stream
    end
  end

  def sibur
    @post = Post.find(params[:id])
    @post.increment!(:sr)
    
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :category, :name)
  end

  def sort_column
    %w[created_at mr sr].include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end