class NotifierPreview < ActionMailer::Preview
  def receipt
    Notifier.receipt(User.first)
  end
end