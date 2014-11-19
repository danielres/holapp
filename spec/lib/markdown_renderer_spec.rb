describe MarkdownRenderer do
  it "renders markdown strings to html" do
    expect( described_class.new.call "**aaa**" ).to eq '<p><strong>aaa</strong></p>'
  end
end
