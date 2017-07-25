defmodule Herald.PageController do
  use Herald.Web, :controller
  alias Herald.SmsGateway, as: HS

  def index(conn, _params) do
    render conn, "index.html"
  end

  def send_message(conn, %{"send_message" => %{"numbers" => numbers, "message" => message}}) do
    IO.inspect("I at least made it here....")
    HS.post("http://smsgateway.me/api/v3/messages/send?email=petersenlance@gmail.com&password=njmm0608&device=53398&number[0]=8017190725&number[1]=4358909237&message=#{message}", "", [], [])
    render conn, "result.html"
  end
end
