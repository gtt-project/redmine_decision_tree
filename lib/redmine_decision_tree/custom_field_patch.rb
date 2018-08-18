# frozen_string_literal: true

module RedmineDecisionTree
  module CustomFieldPatch
    def self.apply
      CustomField.store_accessor :format_store, :decision_tree_json
      CustomField.safe_attributes 'decision_tree_json'
      CustomField.send(:prepend, self) unless CustomField < self
    end

    def validate_custom_field
      super

      if json = decision_tree_json.presence
        tree = DecisionTree.new(json) rescue nil
        unless tree and tree.valid?
          errors.add :decision_tree_json, :invalid
        end
      end
    end
  end
end
