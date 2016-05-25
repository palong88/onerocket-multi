Rails.configuration.stripe = {
  :publishable_key => "pk_test_vDSiuOkeTaV8mLnuOgqAQyWd",

  :secret_key => "sk_test_iBJSneUkCN00sJomUxKxs8yZ"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]