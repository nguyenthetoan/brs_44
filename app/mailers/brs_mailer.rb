class BrsMailer < Devise::Mailer
  layout "mailer"

  helper :application
  default template_path: "users/mailer"

  def confirmation_instructions(record, token, opts={})
    opts[:from] = Settings.mailing.from
    opts[:reply_to] = Settings.mailing.from
    super
  end
end
