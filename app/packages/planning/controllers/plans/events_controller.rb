# frozen_string_literal: true

module Plans
  class EventsController < ApplicationController
    before_action :authenticate_account!
    before_action :load_plan
    before_action :load_event, only: %w(edit update destroy)

    def index
      @events = Event::FindAll
        .call(plan_id: @plan.id)
        .value!
    end

    def new
      @event_form = Event::Create::Form.new
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

    def edit
      @event_form = Event::Update::Form.new(
        @event.attributes
          .slice(:plan_id, :picto_id, :title, :day_of_the_week)
          .merge(event_id: params[:id])
      )
    end

    def update
      response = Event::Update.call(
        **input_data_for_update
      )

      if response.success?
        flash[:notice] = "Evento editado!"
        redirect_to plan_events_path(response.value.id)
      else
        flash.now[:alert] = "Algo ha ido mal!"
        @event_form = response.value.data
        render :edit
      end
    end

    def destroy
      Event::Remove.call(
        plan_id: @plan.id,
        event_id: params[:id]
      )

      redirect_to plan_events_path(@plan.id)
    end

    private

    def load_event
      @event = Event::Find.call(
        plan_id: @plan.id,
        event_id: params[:id]
      ).value!
    end

    def input_data_for_create
      params
        .require(:event_create_form)
        .permit(:picto_id, :title, :day_of_the_week)
        .merge(plan_id: @plan.id)
    end

    def input_data_for_update
      params
        .require(:event_update_form)
        .permit(:picto_id, :title, :day_of_the_week)
        .merge(plan_id: @plan.id, event_id: params[:id])
    end

    def load_plan
      @plan = Plan::Find
        .call(account_id: current_account.id, plan_id: params[:plan_id])
        .value!
    end
  end
end
