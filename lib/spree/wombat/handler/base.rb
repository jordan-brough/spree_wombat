require 'json'

module Spree
  module Wombat
    module Handler
      class Base
        class ErrorResponse < StandardError; end

        attr_accessor :payload, :parameters, :request_id

        def initialize(message)
          self.payload = ::JSON.parse(message).with_indifferent_access
          self.request_id = payload.delete(:request_id)

          if payload.key? :parameters
            if payload[:parameters].is_a? Hash
              self.parameters = payload.delete(:parameters).with_indifferent_access
            end
          end
          self.parameters ||= {}

        end

        def self.build_handler(path, message)
          klass = ("Spree::Wombat::Handler::" + path.camelize + "Handler").constantize
          klass.new(message)
        end

        def response(message, code = 200, exception=nil)
          if code.to_i.between?(500,599)
            if exception.nil?
              exception = ErrorResponse.new(message)
              exception.set_backtrace(caller)
            end
            Honeybadger.notify(exception)
          end
          Spree::Wombat::Responder.new(@request_id, message, code)
        end

        def process
          raise "Please implement the process method in your handler"
        end

      end
    end
  end
end
