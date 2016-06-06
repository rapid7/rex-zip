# -*- coding: binary -*-
require 'spec_helper'

describe Rex::Zip::CompFlags do

  subject(:compflags) { described_class.new(gpbf,compmeth,timestamp) }

  let(:gpbf) { 0 }
  let(:compmeth)  { Rex::Zip::CM_DEFLATE }
  let(:timestamp) { Time.new(2002, 10, 31, 2, 2, 2, "+02:00") }

  it 'should pack down into 4 16-bit unsigned little endian integers' do
    expect(compflags.pack).to eq "\x00\x00\b\x00B\x10_-"
  end

end