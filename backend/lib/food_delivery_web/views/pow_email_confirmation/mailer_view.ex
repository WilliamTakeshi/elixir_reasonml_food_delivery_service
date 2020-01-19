defmodule FoodDeliveryWeb.PowEmailConfirmation.MailerView do
  use FoodDeliveryWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
