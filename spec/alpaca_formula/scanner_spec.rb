# frozen_string_literal: true

# (基本給(月給) + 管理職手当 + 技術管理手当) / 所定労働日数 * (生理休暇 + 休職日数 + 欠勤日数) * -1

RSpec.describe AlpacaFormula::Scanner do
  describe 'ClassMethods' do
    describe '#next_token' do
      subject { tokens }
      let(:instance) { described_class.new }

      def tokens
        result = []

        while token = instance.next_token
          result.push(token)
        end

        result
      end

      before do
        instance.scan_setup(text)
      end

      context 'given symbol' do
        let(:text) { '基本給（月給）' }
        it { is_expected.to eq([[:ITEM, '基本給（月給）']]) }
      end

      context 'given signed value' do
        let(:text) { '+1+-2' }

        it do
          is_expected.to eq(
            [
              [:DIGIT, '+1'],
              [:OPERATOR, '+'],
              [:DIGIT, '-2']
            ]
          )
        end
      end

      context 'given float value' do
        let(:text) { '1.0 + 0.12345 - -1.0' }
        it do
          is_expected.to eq(
            [
              [:DIGIT, '1.0'],
              [:LITERAL, ' '],
              [:OPERATOR, '+'],
              [:LITERAL, ' '],
              [:DIGIT, '0.12345'],
              [:LITERAL, ' '],
              [:OPERATOR, '-'],
              [:LITERAL, ' '],
              [:DIGIT, '-1.0']
            ]
          )
        end
      end

      context 'given sign' do
        let(:text) { '1 + 2 - 3 * 123456789 / 1' }

        it do
          is_expected.to eq(
            [
              [:DIGIT, '1'],
              [:LITERAL, ' '],
              [:OPERATOR, '+'],
              [:LITERAL, ' '],
              [:DIGIT, '2'],
              [:LITERAL, ' '],
              [:OPERATOR, '-'],
              [:LITERAL, ' '],
              [:DIGIT, '3'],
              [:LITERAL, ' '],
              [:OPERATOR, '*'],
              [:LITERAL, ' '],
              [:DIGIT, '123456789'],
              [:LITERAL, ' '],
              [:OPERATOR, '/'],
              [:LITERAL, ' '],
              [:DIGIT, '1']
            ]
          )
        end
      end

      context 'given brackets' do
        let(:text) { '(1 + 2)' }

        it do
          is_expected.to eq(
            [
              [:LPAREN, '('],
              [:DIGIT, '1'],
              [:LITERAL, ' '],
              [:OPERATOR, '+'],
              [:LITERAL, ' '],
              [:DIGIT, '2'],
              [:RPAREN, ')']
            ]
          )
        end
      end

      context 'given shorthund syntax' do
        let(:text) { '(1++2--0)/3' }

        it do
          is_expected.to eq(
            [
              [:LPAREN, '('],
              [:DIGIT, '1'],
              [:OPERATOR, '+'],
              [:DIGIT, '+2'],
              [:OPERATOR, '-'],
              [:DIGIT, '-0'],
              [:RPAREN, ')'],
              [:OPERATOR, '/'],
              [:DIGIT, '3']
            ]
          )
        end
      end

      context 'given sign' do
        let(:text) { ',' }

        it do
          is_expected.to eq(
            [
              [:DELIMITER, ',']
            ]
          )
        end
      end

      fcontext 'given IF' do
        let(:text) { 'IF(基本給 > 0, 1.0, 2.0)' }

        it do
          is_expected.to eq(
            [
              [:IF, 'IF'],
              [:LPAREN, '('],
              [:ITEM, '基本給'],
              [:LITERAL, ' '],
              [:COMPARISON_OPERATOR, '>'],
              [:LITERAL, ' '],
              [:DIGIT, '0'],
              [:DELIMITER, ','],
              [:LITERAL, ' '],
              [:DIGIT, '1.0'],
              [:DELIMITER, ','],
              [:LITERAL, ' '],
              [:DIGIT, '2.0'],
              [:RPAREN, ')']
            ]
          )
        end
      end
    end
  end
end
