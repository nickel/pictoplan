# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_account!
  before_action :load_plan, only: %w(edit update destroy)

  def index
    @plans = Plan::FindAll
      .call(account_id: current_account.id)
      .value!
  end

  def new
    @plan_form = Plan::Create::Form.new
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
      @plan_form = response.value.data
      render :new
    end
  end

  def edit
    @plan_form = Plan::Update::Form.new(
      @plan.attributes
        .slice(:account_id, :name)
        .merge(plan_id: params[:id])
    )
  end

  def update
    response = Plan::Update.call(
      **input_data_for_update
    )

    if response.success?
      flash[:notice] = "Planificación editada!"
      redirect_to plan_events_path(response.value.id)
    else
      flash.now[:alert] = "Algo ha ido mal!"
      @plan = response.value.data
      render :edit
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
    Plan::FindCurrent.call(
      account_id: current_account.id
    ).and_then do |plan|
      @plan = plan
    end
  end

  def destroy
    Plan::Remove.call(
      account_id: current_account.id,
      plan_id: @plan.id
    )

    redirect_to plans_path
  end

  private

  def load_plan
    @plan = Plan::Find.call(
      account_id: current_account.id,
      plan_id: params[:id]
    ).value!
  end

  def input_data_for_create
    params
      .require(:plan_create_form)
      .permit(:name)
      .merge(account_id: current_account.id)
  end

  def input_data_for_update
    params
      .require(:plan_update_form)
      .permit(:name)
      .merge(account_id: current_account.id, plan_id: params[:id])
  end
end
