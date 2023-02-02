class RelationshipsController < ApplicationController
  before_action :authenticate_user!#ログインしていないユーザーはこの画面に遷移できない
  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    redirect_to request.referrer || root_path# 元の画面に戻る
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path# 元の画面に戻る
  end
end