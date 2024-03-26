# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include WithResponse

  primary_abstract_class
end
