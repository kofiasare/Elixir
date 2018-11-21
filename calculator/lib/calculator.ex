defmodule Calculator do
  def start, do: spawn(fn -> loop(0) end)

  defp loop(current_value) do
    new_value =
      receive do
        {:value, client_id} ->
          send(client_id, {:response, current_value})
          current_value

        {:+, value} ->
          current_value + value

        {:-, value} ->
          current_value - value

        {:*, value} ->
          current_value * value

        {:/, value} ->
          current_value / value
      end

    loop(new_value)
  end

  def value(server_id) do
    send(server_id, {:value, self()})

    receive do
      {:response, value} -> value
    end
  end

  def add(server_id, value) do
    send(server_id, {:+, value})
    value(server_id)
  end

  def sub(server_id, value) do
    send(server_id, {:-, value})
    value(server_id)
  end

  def mult(server_id, value) do
    send(server_id, {:*, value})
    value(server_id)
  end

  def div(server_id, value) do
    send(server_id, {:/, value})
    value(server_id)
  end
end
