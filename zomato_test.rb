# frozen_string_literal: true

require 'minitest/autorun'

class ZomatoTest < Minitest::Test
  def test_ask_returns_an_answer
    magic_ball = MagicBall.new
    assert !magic_ball.ask('Whatever').nil?
  end
end
