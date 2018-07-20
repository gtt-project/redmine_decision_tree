class DecisionTree
  attr_reader :current_data, :value, :progress
  def initialize(json)
    @data = JSON.parse json
  end

  def set_progress(progress, current_answer)
    answers = progress.to_s.split(',')
    answers << current_answer if current_answer
    @progress = answers.join(',')
    @current_data = @data
    while a = answers.shift
      @current_data = @current_data['answers'][a.to_i]
    end
    if @value = @current_data['value']
      @finished = true
    end
  end

  def finished?
    !!@finished
  end

end
