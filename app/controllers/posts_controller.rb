class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:index, :new, :create, :show]}

  def index
   @posts = Post.where(user_id: @current_user.id)
   @post = Post.all
  end
  
  def new
    @post = Post.new
  end
 
  def create
    @post = Post.new(post_params)
    if params[:room_image]
      image = params[:room_image]
      File.binwrite("public/post_images/#{@post.room_image}", image.read)
    end
    if @post.save
      redirect_to("/")
      flash[:notice] = "登録完了しました。"
    else
      render("posts/new")
    end
  end
 
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @current_user.id)
    @reser = Reser.new
  end
 
  def search
    if params[:search_area]
      @posts = Post.where("address LIKE ?", "%#{params[:search_area]}%")
    elsif params[:search_keyword]
      @posts = Post.where("room_name LIKE ? OR address LIKE ?","%#{params[:search_keyword]}%", "%#{params[:search_keyword]}%")
    end
  end
  
  private
  def post_params
    params.require(:post).permit( :room_name, :room_introduction, :address, :price, :room_image, :user_id)
  end
  
end