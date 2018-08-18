class DecisionTreesController < ApplicationController

  before_action :authorize_field

  def show
    tree = DecisionTree.new @field.decision_tree_json
    tree.set_progress params[:progress], params[:answer]

    if tree.finished?
      @value = tree.value
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
