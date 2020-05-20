class PollsController < ApplicationController
  before_action :set_poll, only: [:show]
  before_action :set_presenter, only: [:show]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.includes(:votes)
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        sp = Slack::Publisher.new(@poll)
        sp.publish

        format.html { redirect_to @poll, success: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html {
          flash.now[:error] = "Poll can't be created."
          render :new
        }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_presenter
    @presenter = PollsPresenter.new
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_poll
    @poll = Poll.includes(:answers, votes: :answer)
                .where(id: params[:id])
                .first
  end

  # Only allow a list of trusted parameters through.
  def poll_params
    params.fetch(:poll, {}).permit(:name, answers_attributes: [:id, :name, :_destroy])
  end
end
