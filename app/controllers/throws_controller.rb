# frozen_string_literal: true

class ThrowsController < ApplicationController
  require "net/http"

  # RPS game rules (key beats value)
  RULES = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }.freeze

  def show
    @user_choice = params[:choice]
  end

  def lazy_load
    user_choice = params[:choice]
    # Define the API endpoint URL
    api_url = Settings.throw_api_url

    # Prepare the request
    uri = URI(api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"

    # Make the GET request to the API
    response = http.get(uri)

    @computer_choice = if response.is_a?(Net::HTTPSuccess)
                         JSON.parse(response.body)["body"]
                       else
                         RULES.keys.sample
                       end

    # Determine the result of the game
    @result = throw_result(user_choice.to_sym, @computer_choice)
  end

  private

  def throw_result(user_choice, computer_choice)
    if user_choice == computer_choice
      :tied
    elsif RULES[user_choice] == computer_choice
      :won
    else
      :lost
    end
  end
end
