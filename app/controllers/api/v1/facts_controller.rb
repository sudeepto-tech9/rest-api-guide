class Api::V1::FactsController < ApplicationController
  before_action :set_fact, only: [:show, :update, :destroy]

  # GET /api/v1/users/:user_id/facts
  def index
    @facts = Fact.all
    render json: @facts
  end

  # GET /api/v1/users/:user_id/facts/:id
  def show
    render json: @fact
  end

  # POST /api/v1/users/:user_id/facts
  def create
    @fact = Fact.new(fact_params)
    if @fact.save
      render json: @fact
    else
      render json: { error: "Unable to create Fact." }, status: :bad_request # 400
    end
  end

  # PATCH /api/v1/users/:user_id/facts/:id
  def update
    if @fact.valid?
      @fact.update(fact_params)
      render json: { message: "Fact updated succesfully." }, status: :ok # 200
    else
      render json: { error: "Unable to update Fact." }, status: :bad_request
    end
  end

  # DELETE /api/v1/users/:user_id/facts/:id
  def destroy
    if @fact.valid?
      @fact.destroy
      render json: { message: "Fact successfully deleted." }, status: :ok
    else
      render json: { error: "Unable to delete Fact." }, status: :bad_request
    end
  end

  private

  def set_fact
    @fact = Fact.find(params[:id])
  end

  def fact_params
    params.require(:fact).permit(:fact, :likes, :user_id)
  end
end
