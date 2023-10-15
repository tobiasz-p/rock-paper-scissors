# frozen_string_literal: true

require "net/http"

class ThrowsController < ApplicationController
  RULES = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }.freeze

  def show
    @user_choice = params[:choice]
  end

  def lazy_load
    @user_choice = params[:choice]
    @computer_choice = fetch_computer_choice

    @result = determine_result(@user_choice.to_sym, @computer_choice)
  end

  private

  def fetch_computer_choice
    uri = URI(Settings.throw_api_url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"

    response = http.get(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["body"]
    else
      RULES.keys.sample
    end
  end

  def determine_result(user_choice, computer_choice)
    if user_choice == computer_choice
      :tied
    elsif RULES[user_choice] == computer_choice
      :won
    else
      :lost
    end
  end
end
