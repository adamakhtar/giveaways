require 'liquid'

module Giveaways
  class ConfirmationEmailFormatter

    include ActionView::Helpers::TextHelper

    def self.format(entrant)
      new(entrant).format
    end

    def initialize(message:, first_name:, confirmation_path:, referral_path:, chances_per_referral:)
      @message = message
      @first_name = first_name
      @confirmation_path = confirmation_path
      @referral_path = referral_path
      @chances_per_referral = chances_per_referral
    end

    def format
      tags = {
        'first_name' => first_name,
        'confirm_email_link' => link_to(confirmation_path, confirmation_path),
        'referral_link' => referral_path,
        'x_chances' => pluralize(chances_per_referral, "chance")
      }

      processed = simple_format(message)
      processed = ::Liquid::Template.parse(processed).render(tags)
    end

    private

    attr_reader :message, :first_name, :confirmation_path, :referral_path, :chances_per_referral

    def link_to(text, url)
      %Q{<a href="#{url}">#{text}</a>}
    end
  end
end