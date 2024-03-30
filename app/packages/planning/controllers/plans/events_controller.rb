# frozen_string_literal: true

module Plans
  class EventsController < ApplicationController
    before_action :authenticate_account!
    before_action :load_plan

    def index
      @events = Event::FindAll
        .call(plan_id: @plan.id)
        .value!
    end

    def new
      @event = Event::Create::Form.new
    end

    def create
      response = Event::Create.call(
        **input_data_for_create
      )

      if response.success?
        flash[:notice] = "Nuevo evento creado!"
        redirect_to plan_events_path(@plan.id)
      else
        flash.now[:alert] = "Algo ha ido mal!"
        @event = response.value.data
        render :new
      end
    end

    private

    def input_data_for_create
      params
        .require(:event_create_form)
        .permit(:picto_id, :title, :day_of_the_week)
        .merge(plan_id: @plan.id)
    end

    def load_plan
      @plan = Plan::Find
        .call(account_id: current_account.id, plan_id: params[:plan_id])
        .value!
    end
  end
end
