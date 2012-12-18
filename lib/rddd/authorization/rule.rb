module Rddd
  module Authorization
    #
    # Representation of single authorization rule. It applies
    # to a specific action and evaluates the given block to
    # decide the outcome.
    #
    class Rule
      InvalidEvaluationBlock = Class.new(RuntimeError)

      #
      # Initialize.
      #
      # @param [Symbol] Action to apply rule to.
      # @param [Block] Block to be evaluated during authorization.
      #
      def initialize(action, &block)
        # Block should take two arguments - user and params.
        raise InvalidEvaluationBlock unless block.arity == 2

        @action = action
        @block = block
      end

      #
      # Is the Rule for given action?
      #
      # @param {Symbol} Action to be matched.
      # @private
      #
      def is_for?(action)
        @action == action
      end

      #
      # Evalute the rule for a given user and params.
      #
      # @param {Object} User we are gonna authorize.
      # @param {Hash} Auxiliary attributes to decide authorization.
      #
      def can?(user, params)
        @block.call(user, params)
      end
    end
  end
end