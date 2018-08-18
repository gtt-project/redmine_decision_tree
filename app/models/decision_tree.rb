class DecisionTree
  attr_reader :current_data, :value, :progress
  def initialize(json)
    @data = JSON.parse json
  end

  def set_progress(progress, current_answer)
    answers = progress.to_s.split(",")
    answers << current_answer if current_answer
    @progress = answers.join(",")
    @current_data = @data
    while a = answers.shift
      @current_data = @current_data["answers"][a.to_i]
    end
    if @value = @current_data["value"]
      @finished = true
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
