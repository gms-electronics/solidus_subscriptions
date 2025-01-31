# frozen_string_literal: true

module SolidusSubscriptions
  module PermissionSets
    class DefaultCustomer < ::Spree::PermissionSets::Base
      class << self
        def privilege
          :customer
        end

        def category
          :subscription
        end
      end

      def activate!
        can [:show, :display, :update, :skip, :cancel, :pause, :resume], Subscription, ['user_id = ?', user.id] do |subscription, guest_token|
          (subscription.guest_token.present? && subscription.guest_token == guest_token) ||
            (subscription.user && subscription.user == user)
        end

        can [:show, :display, :update, :destroy], LineItem do |line_item, guest_token|
          (line_item.subscription&.guest_token.present? && line_item.subscription.guest_token == guest_token) ||
            (line_item.subscription&.user && line_item.subscription.user == user)
        end
      end
    end
  end
end
