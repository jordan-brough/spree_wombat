module Spree
  module Wombat
    module Handler
      class AddCustomerReturnHandler < Base

        def process
          return response("Please provide a customer_return payload", 400) if customer_return_params.blank?

          # TODO do something real
          response "Customer return was added", 200
        end

        def customer_return_params
          @payload[:customer_return]
        end
      end
    end
  end
end
