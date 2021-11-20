class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:show, :show2, :edit, :update, :update2]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      icon_image: "default_user.jpg",
      password: params[:password],
      password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_email] = @user.email
      redirect_to("/")
      flash[:notice] = "登録完了しました。"
    else
      render("users/new")
    end
  end
  
  def show
    @users = User.find_by(id: params[:id])
  end
  
  def show2
    @users = User.find_by(id: params[:id])
  end
  
 
  def edit
    @users = User.find_by(id: params[:id])
  end
 
  def update
    @users = User.find_by(id: params[:id])
    @current_password = params[:current_password]
    if @users.authenticate(@current_password)
      @users.email = params[:email]
      @users.password = params[:password]
      @users.password_confirmation = params[:password_confirmation]
      if @users.save
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to("/users/#{@users.id}")
      else
        render("users/edit")
      end
    else
     @error_message = "現在のパスワードが間違っています" 
     render("users/edit")
    end
  end
  
  def update2
    @users = User.find_by(id: params[:id])
    @users.name = params[:name]
    @users.introduction = params[:introduction]
    if params[:icon]
      @users.icon_image = "#{@users.id}.jpg"
      image = params[:icon]
      File.binwrite("public/user_images/#{@users.icon_image}", image.read)
    end
    if @users.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@users.id}/show2")
    else
      render("users/show2")
    end
  end
 
  def destroy
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) # パスワードを検証
      session[:user_email] = @user.email # 検証OKなら、セッションにメールアドレスを保存
      flash[:notice] = "ログインしました"
      redirect_to("/") # 一覧画面へ遷移
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("/users/login_form") # パスワード検証NGなら、ログイン画面を再表示
    end
  end
  
  def logout
    session[:user_email] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
