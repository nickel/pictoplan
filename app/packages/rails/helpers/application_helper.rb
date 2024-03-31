# frozen_string_literal: true

module ApplicationHelper
  def day_to_name(day_of_the_week)
    %w(lunes martes miércoles jueves viernes sábado domingo)[day_of_the_week].capitalize
  end

  def input_classes
    "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 " \
      "focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 " \
      "dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
  end

  def label_classes
    "block mb-2 text-sm font-medium text-gray-900 dark:text-white"
  end

  def submit_classes
    "bg-blue-700 hover:bg-blue-800 text-white font-bold py-2 px-4 rounded"
  end
end
