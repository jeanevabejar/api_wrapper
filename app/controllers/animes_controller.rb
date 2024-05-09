class AnimesController < ApplicationController
    before_action :client, only: [:index, :show]

    def index
        @top_anime = client.getTopAnime 
    end

    def show
        id = params[:id]
        @anime = client.getAnimeById(id)
        @anime_rev = client.getAnimeReviews(id)
    end

    private

    def client
     Jikan::V1::Client.new
    end

end