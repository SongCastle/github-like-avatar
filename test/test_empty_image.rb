require_relative 'test_helper'

describe GitHubLikeAvatar::EmptyImage do
  describe '#join' do
    subject do
      GitHubLikeAvatar::EmptyImage.new.join(*args)
    end
    let(:args) { [0, 1] }

    it 'return a first args' do
      expect(subject).must_equal(args[0])
    end
  end
end
