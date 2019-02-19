MoneyRails.configure do |config|
  config.default_currency = :gbp
end

Money.locale_backend = :currency
