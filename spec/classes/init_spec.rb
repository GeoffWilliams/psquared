require 'spec_helper'
describe 'psquared' do
  context 'with default values for all parameters' do
    it { should contain_class('psquared') }
  end
end
