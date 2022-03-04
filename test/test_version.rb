require_relative 'test_helper'

describe GitHubLikeAvatar::VERSION do
  subject { GitHubLikeAvatar::VERSION }

  it 'must be \'1.1.1\'' do
    expect(subject).must_equal('1.1.1')
  end
end
