class ResersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :new, :create, :show]}
  def index
    @resers = Reser.where(user_id: @current_user.id)
  end
  
  def new
    @reser = Reser.new(
       people: params[:people],
       start: params[:start],
       stop: params[:stop],
       post_id: params[:poid],
       user_id: @current_user.id)
    @post = Post.find_by(id: @reser.post_id)
    @user = User.find_by(id: @current_user.id)
    if @reser.invalid? 
     render("posts/show")
    else
      @date_gap = @reser.date_gap.to_i
      @reser.price = @post.price * @reser.people * @date_gap
    end
  end
  
  def create
    @reser = Reser.new( 
      people: params[:people],
      start: params[:start],
      stop: params[:stop],
      post_id: params[:poid],
      user_id: @current_user.id,
      price: params[:price],
      days: params[:days])
    @post = Post.find_by(id: @reser.post_id)
    @user = User.find_by(id: @current_user.id)
    if params[:room_show] || !@reser.save #戻るボタンを押したときまたは、@eventが保存されなかったらnewアクションを実行
      render("posts/show")
    elsif params[:confirm] && @reser.save
      flash[:notice] ="予約完了しました。"
      redirect_to("/resers/#{@reser.id}")
    end 
  end
  
  def show
    @reser = Reser.find_by(id: params[:id])
    @post = Post.find_by(id: @reser.post_id)
  end
end
