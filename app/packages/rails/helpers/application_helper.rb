# frozen_string_literal: true

module ApplicationHelper
  def day_to_name(index)
    days_of_week.find { |day_of_week| day_of_week.id == index }.title
  end

  def days_of_week
    @days_of_week = [1, 2, 3, 4, 5, 6, 0].map do |day_of_week|
      CustomStruct.new(
        id: day_of_week,
        title: I18n.t("date.day_names")[day_of_week],
        today?: Date.today.wday == day_of_week
      )
    end
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
