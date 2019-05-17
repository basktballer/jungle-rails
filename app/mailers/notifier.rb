class Notifier < ApplicationMailer
  default from: 'no-reply@jungle.com',
          return_path: 'system@jungle.com'

  def receipt(order_placed)
    @order_placed = order_placed
    subject = "Your Jungle order has been placed. Order number: #{@order_placed.id}"
    mail(to: @order_placed.email, subject: subject)
  end
end
