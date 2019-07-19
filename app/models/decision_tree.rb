# frozen_string_literal: true

class DecisionTree
  attr_reader :current_data, :value, :progress, :intermediate_values
  def initialize(json)
    @data = JSON.parse json
  end

  def set_progress(progress, current_answer)
    answers = progress.to_s.split(",")
    answers << current_answer if current_answer
    @progress = answers.join(",")
    @current_data = @data
    @intermediate_values = {}
    while a = answers.shift
      @current_data = @current_data["answers"][a.to_i]
      if target = @current_data["target"] and
         intermediate_value = @current_data["intermediate_value"]

        @intermediate_values[target] = intermediate_value
      end
    end
    if @value = @current_data["value"] and @current_data["question"].blank?
      @finished = true
    end
  end

  # moves back one step, returns the id of the last answer
  def back(progress)
    progress = progress.split ','
    if progress.any?
      previous_answer = progress.pop.to_i
      set_progress progress.join(','), nil
      previous_answer
    else
      ''
    end
  end

  def finished?
    !!@finished
  end

  def valid?
    @data["question"].present? and
      answers = @data["answers"] and
      validate_answers(answers)
  rescue
    false
  end

  def validate_answers(answers)
    return false if answers.none?

    answers.all? do |answer|
      answer["option"].present? and
        (answer["value"].present? or
         (answer["question"].present? and
          answers = answer["answers"] and
          validate_answers(answers)
         )
        )
    end
  end

end
