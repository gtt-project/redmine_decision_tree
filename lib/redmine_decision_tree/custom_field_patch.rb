# frozen_string_literal: true

module RedmineDecisionTree
  module CustomFieldPatch
    def self.apply
      CustomField.store_accessor :format_store, :decision_tree_json
      CustomField.safe_attributes 'decision_tree_json'
    end
  end
end
