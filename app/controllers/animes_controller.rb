class AnimesController < ApplicationController
    before_action :client, only: [:index, :show, :index_data, :show_data]

    def index
        @top_anime = client.getTopAnime 
    end

    def show
        id = params[:id]
        @anime = client.getAnimeById(id)
        @anime_rev = client.getAnimeReviews(id)
    end

    def index_data
        @top_anime = client.getTopAnime 
    end

    def show_data
        id = params[:id]
        @anime = client.getAnimeById(id)
        @anime_rev = client.getAnimeReviews(id)
    end

    private

    def client
     Jikan::V1::Client.new
    end

end