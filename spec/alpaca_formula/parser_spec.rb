# frozen_string_literal: true

RSpec.describe AlpacaFormula::Parser do
  describe '.parse' do
    subject { described_class.parse(text) }
    let(:text) { '(基本給（月給）+管理職手当+技術管理手当)/所定労働日数*(生理休暇+休職日数+欠勤日数)*-1' }
    # let(:text) { 'IF(基本給 > 0, 1.0, 2.0)' }
    it { binding.pry; pp subject }
  end
end
