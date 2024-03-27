# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_account!

  def current
  end
end
