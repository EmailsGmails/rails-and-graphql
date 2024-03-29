# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'confirmation' do
    let(:mail) { UserMailer.confirmation(FactoryBot.create(:user, email: 'to@example.org'), 'confirmation-token-123') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Confirmation Instructions')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Click here to confirm your email.')
    end

    it 'should be set to be delivered to the email passed in' do
      expect(mail).to deliver_to('to@example.org')
    end
  end
end
