class PollsPresenter
  def chart_data(poll)
    @chart_data ||= poll.answers.map do |a|
      [a.name, a.votes.size]
    end.to_h
  end

  def answers_data(poll)
    @answers_data ||= poll.answers
                          .map{|a| [a.id, a.name] }
                          .to_h
  end
end
