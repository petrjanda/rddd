require 'rddd/authorization/rule'

module Rddd
  module Authorization
    #
    # Helper module for building list of authorization rules.
    #
    # Usage:
    #
    #   builder = Object.new
    #   builder.extends Rddd::Authorization::RulesBuilder
    #
    #   builder.can :create_project do |user, params|
    #     user.owner? && params[:account_id] == user.account_id
    #   end
    #
    #
    #   # This part happens inside framework
    #   authorizer = Rddd::Authorization::Authorize.new(builder.rules, user)
    #   authorizer.can?(:create_project, {:account_id => 123})
    #
    #
    # Call to can method define the rule for a given action. The block
    # always takes the user instance and additional parameters which
    # specify details for the performed action.
    #
    module RulesBuilder
      attr_reader :rules

      #
      # Create new rule applied to specified action and perform the given
      # block.
      #
      # @param {Symbol | Array} Action the rule applies to.
      # @param {Block} Block to be executed to evaluate authorization.
      #
      def can(action, &block)
        actions = action.kind_of?(Array) ? action : [action]
        @rules ||= []
        @rules.concat actions.map { |action| Rule.new(action, &block) }
      end
    end
  end
end