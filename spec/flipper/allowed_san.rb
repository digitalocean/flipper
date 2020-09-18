require 'helper'

RSpec.describe Flipper::AllowedSan do
  let :edge_san do
    "*.edge.staff.digitalocean.com"
  end

  let :test_san do
    "*.test.staff.digitalocean.com"
  end

  it 'initializes with and knows flipper_id' do
    actor = described_class.new(edge_san)
    expect(actor.flipper_id).to eq(edge_san)
  end

  describe '#eql?' do
    it 'returns true if same class and flipper_id' do
      actor1 = described_class.new(edge_san)
      actor2 = described_class.new(edge_san)
      expect(actor1.eql?(actor2)).to be(true)
    end

    it 'returns false if same class but different flipper_id' do
      actor1 = described_class.new(edge_san)
      actor2 = described_class.new(test_san)
      expect(actor1.eql?(actor2)).to be(false)
    end

    it 'returns false for different class' do
      actor1 = described_class.new(edge_san)
      actor2 = Struct.new(:flipper_id).new(edge_san)
      expect(actor1.eql?(actor2)).to be(false)
    end
  end

  describe '#==' do
    it 'returns true if same class and flipper_id' do
      actor1 = described_class.new(edge_san)
      actor2 = described_class.new(edge_san)
      expect(actor1.==(actor2)).to be(true)
    end

    it 'returns false if same class but different flipper_id' do
      actor1 = described_class.new(edge_san)
      actor2 = described_class.new(test_san)
      expect(actor1.==(actor2)).to be(false)
    end

    it 'returns false for different class' do
      actor1 = described_class.new(edge_san)
      actor2 = Struct.new(:flipper_id).new(edge_san)
      expect(actor1.==(actor2)).to be(false)
    end
  end
end
