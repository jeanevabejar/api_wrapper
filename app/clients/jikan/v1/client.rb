class Jikan::V1::Client

  BASE_URL = 'https://api.jikan.moe/v4'.freeze

  ERROR_CODES = {
    400 => 'Bad Request',
    401 => 'Unauthorized',
    403 => 'Forbidden',
    404 => 'Not Found',
    429 => 'Too Many Requests',
    500 => 'Internal Server Error',
    502 => 'Bad Gateway',
    503 => 'Service Unavailable',
    504 => 'Gateway Timeout'
  }.freeze

  def getTopAnime
    request(
      method: :get,
      endpoint: "top/anime"
    )
  end

  def getAnimeById(mal_id)
    request(
      method: :get,
      endpoint: "anime/#{mal_id}"
    )
  end

  def getAnimeReviews(mal_id, **params)
    request(
      method: :get,
      endpoint: "anime/#{mal_id}/reviews",
      params: params
    )
  end

  private

  def request(method:, endpoint:, params: {}, headers: {}, body: {})
    response = connection.public_send(method, "#{endpoint}") do |request|
      request.params = { **params } if params.present?
      request.headers = headers   if headers.present?
      request.body = body.to_json if body.present?
    end

    if response.success?
      JSON.parse(response.body).with_indifferent_access
    else
      error_message = ERROR_CODES[response.status] || 'Unknown Error'
      raise "#{response.status} - #{error_message}"
    end
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end
