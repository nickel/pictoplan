# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_account!

  def index
    @plans = Plan::FindAll
      .call(account_id: current_account.id)
      .value!
  end

  def new
    @plan = Plan::Create::Form.new
  end

  def create
    response = Plan::Create.call(
      **input_data_for_create
    )

    if response.success?
      flash[:notice] = "Nueva planificación creada!"
      redirect_to plan_events_path(response.value.id)
    else
      flash.now[:alert] = "Algo ha ido mal!"
      @plan = response.value.data
      render :new
    end
  end

  def activate
    response = Plan::Activate.call(
      account_id: current_account.id, plan_id: params[:id]
    )

    if response.success?
      flash[:notice] = "Nueva planificación creada!"
    else
      flash[:alert]  = "Algo ha ido mal!"
    end

    redirect_to plans_path
  end

  def current
    @plan = Plan::FindCurrent.call(
      account_id: current_account.id
    ).value
  end

  private

  def input_data_for_create
    params
      .require(:plan_create_form)
      .permit(:name)
      .merge(account_id: current_account.id)
  end
end
