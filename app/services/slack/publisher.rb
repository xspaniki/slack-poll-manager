class Slack::Publisher
  include Slack::Concerns::GeneralHelper

  attr_reader :poll

  def initialize(poll)
    @poll = poll
  end

  def publish
    begin
      RestClient.post(url, body, headers)
    rescue
      ;
    end
  end

  private

  def url
    ENV['SLACK_PUBLISH_HOOK']
  end

  def body
    poll_message(poll).to_json
  end
end
