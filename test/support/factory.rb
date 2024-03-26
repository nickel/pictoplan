# frozen_string_literal: true

module Factory
  module_function

  def generate_account
    Account # Transform it to operation
      .new(email: "account+#{Time.now.to_f}@pictoplan.com",
           password: "random-pass")
      .save_with_response
      .value!
  end

  def generate_plan(**input)
    Plan::Create
      .call(
        account_id: input.fetch(:account_id, generate_account.id),
        name: "This is a plan"
      ).value!
  end
end
