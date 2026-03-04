module InertiaSharedData
  extend ActiveSupport::Concern

  included do
    inertia_share do
      {
        flash: {notice: flash.notice, alert: flash.alert},
        current_user: current_user&.slice(:id, :email, :name),
        native_app: native_app?,
        user_signed_in: user_signed_in?,
        title: @page_title,
        native_form: @native_form || false
      }
    end
  end
end
