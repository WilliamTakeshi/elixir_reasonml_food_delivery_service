defmodule FoodDeliveryWeb.PowResetPassword.MailerView do
  use FoodDeliveryWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
