require 'spec_helper'

module Spree
  module Wombat
    describe Handler::AddCustomerReturnHandler do

      context "#process" do
        let(:handler) { Handler::AddCustomerReturnHandler.new(message.to_json) }
        let(:responder) { handler.process }

        context "with customer_return payload" do
          let(:message) { { customer_return: 1 } }

          it "returns a Hub::Responder" do
            expect(responder.class.name).to eql "Spree::Wombat::Responder"
          end

          it "has the correct request_id" do
            expect(responder.request_id).to eql message["request_id"]
          end

          it "succeeds" do
            expect(responder.summary).to eql "Customer return was added"
            expect(responder.code).to eql 200
          end
        end

        context "without customer_return payload" do
          let(:message) { { a: 1 } }

          it "returns a Hub::Responder" do
            expect(responder.class.name).to eql "Spree::Wombat::Responder"
          end

          it "has the correct request_id" do
            expect(responder.request_id).to eql message["request_id"]
          end

          it "fails" do
            expect(responder.summary).to eql "Please provide a customer_return payload"
            expect(responder.code).to eql 400
          end
        end
      end

    end
  end
end
