class DecisionTreesController < ApplicationController

  before_action :authorize_field

  def show
    tree = DecisionTree.new @field.decision_tree_json
    if params[:back].present?
      @selected_answer = tree.back params[:progress]
    else
      tree.set_progress params[:progress], params[:answer]
    end

    if tree.finished?
      @value = tree.value
      @intermediate_values = tree.intermediate_values
    else
      data = tree.current_data
      @question = data['question']
      @answers = data['answers']
      @progress = tree.progress
    end

    respond_to :js
  end

  private

  def authorize_field
    @field = CustomField.visible.find_by_id params[:field_id]
    @field.present? || deny_access
  end

end
