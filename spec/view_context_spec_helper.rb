RSpec.configure do |config|
  config.include ActiveSupport::Testing::SetupAndTeardown #,  example_group: {file_path: %r{spec/contexts}}
  config.include ActionView::TestCase::Behavior #, example_group: {file_path: %r{spec/contexts}}
  config.before(:each) { setup_with_controller }
end

def view_context
  view
end
