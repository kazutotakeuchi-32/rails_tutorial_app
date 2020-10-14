ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


# def random_subdomain()
#   ("a".."z").to_a.sample(8).join
# end

# def string_shuffle(s)
#   "foobar".split("").shuffle.join
#  end
# person1={first:"e",last:"ff"}
# person2={first:"ss",last:"w"}
# person3={first:"q",last:"gg"}
# params ={}
# params[:father]=person1
# params[:mother]=person2
# params[:child] =person3
# class Word
#   def initialize
#     @name="ddd"
#   end
#   def name
#    p self
#     puts  @name
#   end
#   def self.aa
#     p self
#     puts "ssssss"
#   end
# end
# class Word              # WordクラスはStringクラスを継承する
#    # 文字列が回文であればtrueを返す
#    def initialize(name,age)
#      @name=name
#      @age = age
#    end

#     def palindrome?
#       puts @name.reverse
#    end
#  end
class String
  def shuffle
    split("").shuffle.join
  end
end
