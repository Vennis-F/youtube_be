module Rmt
  class Exceptions
    CODES = [
      INVALID_SUBDOMAIN                   = 1001,
      STRIPE_ERROR                        = 1002,
      SUBSCRIPTION_ERROR                  = 1003,
      UPGRADE_PLAN_ERROR                  = 1_004
    ]
    class Error < StandardError; end
    class Authentication < StandardError; end
    class InvalidToken < Error; end
    class NonExitsUser < Error; end
  end
end
