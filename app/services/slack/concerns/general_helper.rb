require 'rest-client'

module Slack::Concerns::GeneralHelper
  def poll_message(poll)
    {
      "text": poll.name,
      "attachments": [
        {
          "text": "Vote your option:",
          "fallback": "You are unable to vote!",
          "callback_id": "poll",
          "color": "#3AA3E3",
          "attachment_type": "default",
          "actions": poll.answers.map do |answer|
            votes = answer.votes.size

            {
              "name": "answer",
              "text": answer.name + (votes > 0 ? " [#{votes}]" : ''),
              "type": "button",
              "value": answer.id.to_s,
              "confirm": {
                "title": "Are you sure?",
                "text": "You can only vote once!",
                "ok_text": "Yes",
                "dismiss_text": "No"
              }
            }
          end
        }
      ]
    }.deep_stringify_keys
  end

  private

  def headers
    {
      'Content-Type' => 'application/json'
    }
  end
end
