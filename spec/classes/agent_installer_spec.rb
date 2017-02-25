require 'spec_helper'
describe 'psquared::agent_installers' do
  context "catalog compiles" do
    it { should compile}
  end
    
  context 'with default values for all parameters' do
    it { should contain_class('psquared::agent_installers') }
  end
end
