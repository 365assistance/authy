defmodule Authy.PhoneVerificationTest do
  use ExUnit.Case, async: false
  import Authy.PhoneVerification

  setup_all do
    defaults = [via: "sms", country_code: "61"]
    Application.put_env(:authy, :phone_verification, defaults)
    on_exit fn -> Application.delete_env(:authy, :phone_verification) end
    :ok
  end

  test "start calls post_fn with given params" do
    params = %{via: "call", phone_number: "0477777777", country_code: "44"}
    assert_params = fn (p) -> assert p == params end
    start(params, assert_params)
  end

  test "start pulls defaults from settings" do
    params = %{phone_number: "0477777777"}
    assert_params = fn (p) -> assert p == %{via: "sms", phone_number: "0477777777", country_code: "61"} end
    start(params, assert_params)
  end
end
