class Api::V1::VotesController < Api::V1::ApiController
  # POST /api/v1/votes
  # POST /api/v1/votes.json
  def create
    service = Slack::Subscriber.new(params)
    @vote = service.subscribe

    if @vote
      if @vote.save
        PollChannel.broadcast_to @vote.poll, @vote.to_json(methods: :poll_id)
      end

      service.react
      head 200
    else
      head 400
    end
  end
end
