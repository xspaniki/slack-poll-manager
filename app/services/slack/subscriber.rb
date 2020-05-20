class Slack::Subscriber
  include Slack::Concerns::GeneralHelper

  attr_reader :payload, :vote

  def initialize(data)
    @payload = JSON.parse(data['payload'])
  end

  def subscribe
    return nil unless verified?

    @vote = Polls::Vote.new({
      answer_id: parse_answer_id,
      uid: parse_uid
    })
  end

  def react
    begin
      RestClient.post(url, body, headers)
    rescue
      ;
    end
  end

  private

  def body
    data = if vote.persisted?
      {
        "replace_original": true
      }.merge(poll_message(vote.poll))
    else
      {
        "response_type": "ephemeral",
        "replace_original": false,
        "text": "Ooops, that didn't work. Because you already voted ;-("
      }
    end

    data.to_json
  end

  def url
    payload['response_url']
  end

  def parse_answer_id
    actions = payload['actions']
    action = actions.find{|a| a['name'] == 'answer' }
    action ? action['value'] : nil
  end

  def parse_uid
    user = payload['user']
    user ? user['name'] : nil
  end

  def verified?
    payload['token'] == ENV['SLACK_VERIFICATION_TOKEN']
  end
end
