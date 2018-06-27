require_relative 'version'

module Codebreaker
  class Game
    attr_reader :max_attempt, :secret_code, :rand_index
    attr_accessor :scores_file

    def initialize
      @secret_code = ''
      @max_attempt = 6
      @current_input = 0
      @hint = true
      @rand_index = rand(0...3)
    end

    def start
      4.times { @secret_code << rand(1...6).to_s }
    end

    def input_code(input)
      if input == '7'
        hint
      else
        input = input.to_s
        @input_code = input
        get_result_processing
      end
    end

    def save_result(name, count_attempts)
      File.open('lib/codebreaker/tmp/result.txt', 'w') do |file|
        file.puts "Gamer: #{name}; Attempts: #{count_attempts + 1}"
      end
      p "Gamer: #{name}; Attempts: #{count_attempts + 1}"
    end

    private

    def get_result_processing
      @current_input += 1
      raise 'Code must contain 4 numbers from 1 to 6' unless @input_code =~ /^[1-6]{4}$/
      return true if @input_code == @secret_code
      return false if @current_input >= @max_attempt

      result = ''

      @input_code.chars.each_with_index do |char, index|
        result[index] = if @secret_code.include?(char)
                          if char == @secret_code[index]
                            '+'
                          else
                            '-'
                          end
                        else
                          '.'
                        end
      end

      result
    end

    def hint
      if @hint
        hint = ''
        @secret_code.chars.each_with_index do |char, index|
          hint << if index == @rand_index
                    char
                  else
                    '.'
                  end
        end

        @hint = false
        hint
      else
        p 'hint used'
      end
    end
  end
end
