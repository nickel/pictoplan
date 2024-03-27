# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to current_plan_path if account_signed_in?
  end
end
