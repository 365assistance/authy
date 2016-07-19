defmodule Authy.PhoneVerificationTest do
  use ExUnit.Case, async: false
  import Authy.PhoneVerification

  test "start calls HTTPClient.post! with given params" do
    params = %{via: "call", phone_number: "0477777777", country_code: "44"}
    start(params)
    assert_receive {:post!, _, ^params, _, _}
  end

  test "start pulls defaults from settings" do
    start(%{phone_number: "0477777777"})
    assert_receive {:post!, _, %{via: :sms, phone_number: "0477777777", country_code: 61}, _, _}
  end

  test "check calls HTTPClient.get! with given params" do
    params = %{phone_number: "0477777777", country_code: "44", verification_code: "BLAH"}
    check(params)
    assert_receive {:get!, _, _, [params: ^params]}
  end

  test "check pulls default country_code from settings" do
    check(%{phone_number: "0477777777", verification_code: "BLAH"})
    assert_receive {:get!, _, _, [params: %{phone_number: "0477777777", country_code: 61, verification_code: "BLAH"}]}
  end
end
