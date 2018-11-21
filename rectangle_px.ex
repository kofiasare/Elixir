defmodule Rectangle do
  def start, do: spawn(fn -> loop() end)

  defp loop do
    receive do
      {:a, l, b, operator} -> send(operator, {:response, l * b })
      {:p, l, b, operator} -> send(operator, {:response, 2 * (l + b) })
    end
    loop()
  end

  def area(p, x, y) do
    send p, {:a, x,y, self()}
    receive do
      {:response, area} -> area
    end
  end

  def perimeter(p, x, y) do
    send p, {:p, x,y, self()}
    receive do
      {:response, perimeter} -> perimeter
    end
  end
end
