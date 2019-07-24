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
      if decision_tree_json.present? and not (
           tree = decision_tree and tree.valid?
         )

        errors.add :decision_tree_json, :invalid
      end
    end

    def decision_tree
      if json = decision_tree_json.presence
        DecisionTree.new(json) rescue nil
      end
    end
  end
end
