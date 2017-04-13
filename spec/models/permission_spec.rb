require "spec_helper"

desvribe Permission, focus: true do 
  discribe "as guest" do
    subject { Permission.new(nil) }
    it { should allow("topics", "index") }
  end
end