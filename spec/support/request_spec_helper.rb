module RequestSpecHelper
  # parse json body to ruby hash
  def json
    JSON.parse(response.body)
  end
end
