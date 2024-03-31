# frozen_string_literal: true

class PictosController < ApplicationController
  before_action :authenticate_account!

  def index
    @pictos = Picto::FindAll
      .call(
        keyword: params[:q],
        enabled: !params[:only_disabled].present?,
        page: params[:page]
      ).value!
  end

  def enable
    Picto::Enable
      .call(picto_id: params[:id])

    redirect_to pictos_path(q: params[:q], only_disabled: params[:only_disabled])
  end

  def disable
    Picto::Disable
      .call(picto_id: params[:id])

    redirect_to pictos_path(q: params[:q], only_disabled: params[:only_disabled])
  end
end
