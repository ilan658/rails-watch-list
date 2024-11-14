# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'net/http'
require 'json'

# URL de l'API pour récupérer les films les mieux notés
url = URI("https://tmdb.lewagon.com/movie/top_rated")

# Faire la requête HTTP pour obtenir les données
response = Net::HTTP.get(url)
movies = JSON.parse(response)["results"]

# Créer les films dans la base de données
movies.each do |movie_data|
  Movie.create(
    title: movie_data["title"],
    overview: movie_data["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}",
    rating: movie_data["vote_average"]
  )
end
