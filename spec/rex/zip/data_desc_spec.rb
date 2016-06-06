# -*- coding: binary -*-
require 'spec_helper'

describe Rex::Zip::DataDesc do

  subject(:datadesc) { described_class.new(compinfo) }

  let(:compinfo) { Rex::Zip::CompInfo.new(crc, compdata.length, data.length) }

  let(:data) { 'some random text to compress'}
  let(:crc)  { Zlib.crc32(data,0) }
  let(:compdata) {
    z = Zlib::Deflate.new(Zlib::BEST_COMPRESSION)
    compressed_data = z.deflate(data, Zlib::FINISH)
    z.close
    compressed_data[2, compressed_data.length - 6]
  }

  it 'should pack into 4 32-bit unsigned little endian integers' do
    expect(datadesc.pack).to eq "PK\a\b\x17T\xD9\xC8\x1E\x00\x00\x00\x1C\x00\x00\x00"
  end

  it 'should include the packed value of the supplied compression info block' do
    expect(datadesc.pack).to include(compinfo.pack)
  end

end