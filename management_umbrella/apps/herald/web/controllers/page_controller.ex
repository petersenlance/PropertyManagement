defmodule Herald.PageController do
  use Herald.Web, :controller
  alias Herald.SmsGateway, as: HS
  alias Herald.DB.SQL.Tenant

  def index(conn, _params) do
    render conn, "index.html"
  end

  def send_message(conn, params) do
    message_params = params["send_message"]
    message = message_params["message"]
    phone_numbers = get_phone_numbers(message_params)
    # phone_numbers = "number[]=4358909237&number[]=8017190725" --> A format that actually works!!!
    HS.post("http://smsgateway.me/api/v3/messages/send?email=petersenlance@gmail.com&password=managementsmsgateway&device=55491&#{phone_numbers}message=#{message}", "", [], [])
    # HS.post("http://smsgateway.me/api/v3/messages/send", "", [], params: [{"email", "petersenlance@gmail.com"}, {"password", "managementsmsgateway"}, {"device", "55491"}, {"message", message}, {"number[]", "4358909237"}, {"number[]", "8017190725"}])
    render conn, "result.html"
  end

  def get_phone_numbers(params) do
    case (params["all"]) do
      "true" ->
        Tenant.get_all()
        |> _concat_nums()
      "false" ->
        case (params["big_lot"]) do
          "true" ->
            Tenant.get_big_lot
            |> _concat_nums()
          "false" ->
            "" <> _get_build_nums("build_one", params)
            <> _get_build_nums("build_two", params)
            <> _get_build_nums("build_three", params)
            <> _get_build_nums("build_four", params)
            <> _get_build_nums("build_five", params)
            <> _get_build_nums("build_six", params)
            <> _get_build_nums("build_seven", params)
            <> _get_build_nums("build_eight", params)
        end
    end
  end

  defp _concat_nums(list) do
    list
    |> Enum.map(fn(tenant) -> tenant.phone_number end)
    |> Enum.reduce("", fn(number, acc) ->
      acc <> "number[]=#{number}&"
    end)
  end

  defp _get_build_nums(building, params) do
    case (params[building]) do
      "true" ->
        Tenant.get_by_building(_map_build_to_addr(building))
        |> _concat_nums()
      "false" ->
        ""
    end
  end

  defp _map_build_to_addr(building) do
    case building do
      "build_one" -> 706
      "build_two" -> 710
      "build_three" -> 712
      "build_four" -> 718
      "build_five" -> 722
      "build_six" -> 726
      "build_seven" -> 730
      "build_eight" -> 1
    end
  end
end
