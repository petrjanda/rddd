module Rddd
  #
  # Authorize plugin stores all the authorization rules
  # and answers the question if specific user is or is
  # not authorized to perform the action considering the
  # parameters as well.
  #
  module Authorization
    class Authorize
      #
      # Initialize.
      #
      # @param {Array} List of Rddd::Authorization::Rule.
      # @param {Object} User we are gonna authorize.
      #
      def initialize(rules, user)
        @rules = rules
        @user = user
      end

      #
      # Authorize given action.
      #
      # @param {Symbol} Action to be authorized.
      # @param {Hash} Auxiliary attributes to decide authorization.
      #
      def can?(action, params = {})
        rule = find_rule(action)

        return true unless rule
        
        rule.can?(@user, params)
      end

      private

      def find_rule(action)
        @rules.find { |rule| rule.is_for?(action) }
      end
    end
  end
end