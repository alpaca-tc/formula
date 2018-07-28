# frozen_string_literal: true

RSpec.describe AlpacaFormula::Visitor do
  describe '.accept' do
    subject do
      described_class.new(context).accept(node)
    end

    let(:context) do
      # 事業所と従業員を渡して、動的な値を取得できるクラスを用意するのじゃろう
      Class.new do
        def item_value(node)
          case node.item_name
          when '基本給（月給）'
            600_000
          when '管理職手当'
            50_000
          when '技術管理手当'
            30_000
          when '所定労働日数'
            20
          when '生理休暇'
            0
          when '休職日数'
            0
          when '欠勤日数'
            1
          else
            user_defined_value(node)
          end
        end

        private

        def user_defined_value(_node)
          # ユーザーが定義した変数を参照しにいく。
          # とりあえずは0を返すね
          0
        end
      end.new
    end

    let(:node) { AlpacaFormula::Parser.parse(text) }
    let(:text) { '(基本給（月給）+管理職手当+技術管理手当)/所定労働日数*(生理休暇+休職日数+欠勤日数)*-1' }
    it { pp subject }
  end
end
