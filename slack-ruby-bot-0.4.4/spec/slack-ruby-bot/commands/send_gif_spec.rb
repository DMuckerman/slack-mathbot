require 'spec_helper'

describe SlackRubyBot::Commands do
  let! :command do
    Class.new(SlackRubyBot::Commands::Base) do
      command 'send_gif_spec' do |client, data, _match|
        send_gif client, data.channel, 'dummy'
      end
    end
  end
  def app
    SlackRubyBot::App.new
  end
  let(:client) { app.send(:client) }
  let(:gif_image_url) { 'http://media2.giphy.com/media/pzOijFsdDrsS4/giphy.gif' }
  it 'sends a gif' do
    gif = Giphy::RandomGif.new('image_url' => gif_image_url)
    expect(Giphy).to receive(:random).and_return(gif)
    expect(SlackRubyBot::Commands::Base).to receive(:send_client_message).with(client, channel: 'channel', text: gif_image_url)
    app.send(:message, client, text: "#{SlackRubyBot.config.user} send_gif_spec message", channel: 'channel', user: 'user')
  end
  it 'eats up the error' do
    expect(Giphy).to receive(:random) { fail 'oh no!' }
    expect(SlackRubyBot::Commands::Base).to receive(:send_client_message).with(client, channel: 'channel', text: '')
    app.send(:message, client, text: "#{SlackRubyBot.config.user} send_gif_spec message", channel: 'channel', user: 'user')
  end
  it 'eats up nil gif' do
    expect(Giphy).to receive(:random).and_return(nil)
    expect(SlackRubyBot::Commands::Base).to receive(:send_client_message).with(client, channel: 'channel', text: '')
    app.send(:message, client, text: "#{SlackRubyBot.config.user} send_gif_spec message", channel: 'channel', user: 'user')
  end
end
