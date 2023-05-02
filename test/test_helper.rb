# frozen_string_literal: true

require "minitest/autorun"
require "pry"

Dir["./app/*.rb"].sort.each { |file| require file }