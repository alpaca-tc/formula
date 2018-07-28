# frozen_string_literal: true

RSpec.describe MfFormula::Parser do
  describe '.parse' do
    subject { described_class.parse(text) }
    let(:text) { '(基本給（月給）+管理職手当+技術管理手当)/所定労働日数*(生理休暇+休職日数+欠勤日数)*-1' }
    it { pp subject }
  end
end
