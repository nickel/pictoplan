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
    "text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 " \
    "font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 " \
    "dark:hover:bg-blue-700 dark:focus:ring-blue-800"
  end
end
