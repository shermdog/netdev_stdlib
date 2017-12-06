# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:tacacs_global) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'it has a string property', :key
  it_behaves_like 'array of strings property', attribute: :source_interface
  it_behaves_like 'array of strings property', attribute: :vrf

  describe 'key_format' do
    let(:attribute) { :key_format }
    include_examples 'numeric parameter', min: 0, max: 7
  end

  describe 'timeout' do
    let(:attribute) { :timeout }
    include_examples 'accepts values without munging', %w(0 unset)
    include_examples 'rejects values', %w(foo -1)
  end

  describe 'retransmit_count' do
    let(:attribute) { :retransmit_count }
    include_examples 'numeric parameter', min: 0, max: 2048
  end
end
