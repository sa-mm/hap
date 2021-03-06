defmodule HAP.Configuration do
  def config do
    # TODO - all of these values are different on every call. Be 
    # smarter about aligning them with HAP's lifetime expectations
    {ltpk, ltsk} = HAP.Crypto.EDDSA.key_gen()

    %{ltpk: ltpk, ltsk: ltsk, setup_id: random_setup_id(), pairing_code: random_pairing_code()}
    |> Map.merge(Application.get_env(:hap, :accessory))
  end

  defp random_setup_id do
    Stream.repeatedly(fn -> <<Enum.random(?A..?Z)>> end) |> Enum.take(4) |> Enum.join()
  end

  defp random_pairing_code do
    "#{random_digits(3)}-#{random_digits(2)}-#{random_digits(3)}"
  end

  defp random_digits(number) do
    Stream.repeatedly(&random_digit/0) |> Enum.take(number) |> Enum.join()
  end

  defp random_digit do
    Enum.random(0..9)
  end
end
