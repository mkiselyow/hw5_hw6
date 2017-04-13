require 'rails_helper'

RSpec.describe Topic, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

require 'spec_helper'


describe "Topic request" do 
  log_in admin: false
  topic = create(:topic)
  visit edit_topic_path(topic)
  page.should have_content("Not authorized")
end