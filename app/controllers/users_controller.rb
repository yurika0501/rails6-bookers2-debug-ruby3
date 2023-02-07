class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    #投稿数グラフ出力　gem groupdateをインストールしないと下記の記述は使用不可
    @books_count = Book.group_by_day_of_week(:created_at).size
    #投稿数グラフ出力　gem groupdateをインストールしないと下記の記述は使用不可
    @book_today = Book.where(created_at: Date.today.all_day).count
  end

  def index
    # @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @users2 = User.where.not(id: current_user.id)#カレントユーザー以外のidをとってくる
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user =User.find(params[:id])
    @users = user.followers
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
