require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    context '#start' do
      before do
        game.start
      end

      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/^[1-6]{4}$/)
      end
    end

    context '#input_code' do
      it 'test method called by input validate' do
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.input_code('1234')).to be true
        expect(game.input_code('1235')).to eq('+++.')
        expect(game.input_code('5555')).to eq('....')
        expect(game.input_code('1334')).to eq('+-++')
        expect(game.input_code('4551')).to eq('-..-')
      end
      it 'test method called by input not validate' do
        game.instance_variable_set(:@secret_code, '1234')
        expect { game.input_code('8abcd erer') }.to raise_exception
        expect { game.input_code('') }.to raise_exception
      end
      it 'test method called by input fot hint' do
        game.instance_variable_set(:@secret_code, '1234')
        rand_index = game.instance_variable_get(:@rand_index)
        hint = ''
        game.instance_variable_get(:@secret_code).chars.each_with_index do |char, index|
          hint << if index == rand_index
                    char
                  else
                    '.'
                  end
        end
        expect(game.input_code('7')).to eq(hint)
      end
    end

    context '#save_result' do
      it 'return this function' do
        name = 'Petrov'
        count_attempts = 4
        expect(game.save_result(name, count_attempts)).to eq('Gamer: Petrov; Attempts: 5')
      end
      it 'saving the result to a file' do
        result = File.read('lib/result.txt')
        expect(result).to eq("Gamer: Petrov; Attempts: 5\n")
      end
    end
  end
end
