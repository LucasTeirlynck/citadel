module Users
  class NotificationsController < ApplicationController
    before_action :require_login

    before_action only: [:show, :destroy] do
      @notification = current_user.notifications.find(params[:id])
    end
    skip_after_action :track_action, only: :index

    def index
      render :index, formats: [:js]
    end

    def clear
      @notifications.destroy_all
      index
    end

    def show
      @notification.update!(read: true)
      redirect_to @notification.link
    end

    def destroy
      @notification.destroy
      index
    end
  end
end
