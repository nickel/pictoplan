# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_account!

  def index
  end
end
