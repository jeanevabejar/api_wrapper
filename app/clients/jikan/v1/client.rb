class Jikan::V1::Client

    BASE_URL = 'https://api.jikan.moe/v4'.freeze

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

    return JSON.parse(response.body).with_indifferent_access if response.success?
    # raise ERROR_CODES[response.status]
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
    
end