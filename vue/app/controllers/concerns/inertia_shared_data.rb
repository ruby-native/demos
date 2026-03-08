module InertiaSharedData
  extend ActiveSupport::Concern

  included do
    inertia_share do
      {
        flash: {notice: flash.notice, alert: flash.alert},
        current_user: current_user&.slice(:id, :email, :name),
        user_signed_in: user_signed_in?,
        title: @page_title
      }
    end
  end
end
