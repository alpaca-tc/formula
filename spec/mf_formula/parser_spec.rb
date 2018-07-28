# frozen_string_literal: true

RSpec.describe MfFormula::Parser do
  describe '.parse' do
    subject { described_class.parse('/') }
    it { is_expected.to be_a MfFormula::Nodes::Literal }
  end
end
