class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:show, :show2]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
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
    @user = User.find_by(id: params[:id])
  end
  
 
  def edit
    @user = User.find_by(id: params[:id])
  end
 
  def update
    if params[:email_edit]
      @user = User.find_by(id: params[:id])
      if @user.authenticate(params[:pass])
        @user.update(user_params)
       
        if @user.save
          session[:user_email] = @user.email 
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/users/#{@user.id}")
        else
          render("users/edit")
        end
      else
       @error_message = "現在のパスワードが間違っています" 
       render("users/edit")
      end
    elsif params[:show2_edit]
      @user = User.find_by(id: params[:id])
      @user.update(user_params)
      if params[:icon]
        @user.icon_image = "#{@user.id}.jpg"
        image = params[:icon]
        File.binwrite("public/user_images/#{@user.icon_image}", image.read)
      end     
      if @user.save
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to("/users/#{@user.id}/show2")
      else
        render("users/show2")
      end
    end
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
  
  private
  def user_params
    params.require(:user).permit( :name, :email, :password_digest, :introduction, :icon_image, :password_confirmation, :password)
  end
end
