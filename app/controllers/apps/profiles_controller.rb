class Apps::ProfilesController < Apps::ApplicationController

  def show
    @profile = current_user.profile
    @articles = current_user.articles
  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:alert] = "プロフィールを更新出来ませんでした"
      rander :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:nickname, :introduction, :gender, :birthday, :subscribed, :avatar)
  end
end