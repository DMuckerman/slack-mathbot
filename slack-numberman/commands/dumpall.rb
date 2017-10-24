module SlackMathbot
  module Commands
    class DumpAll < SlackRubyBot::Commands::Base
      operator '!=' do |client, _data, _match|
        # original api key, donut steel
        Wolfram.appid = "R3KHQ2-2T2769PP4P"
        
        # Get equation part of argument
        eq = _match[1..-1]

        # Get results from Wolfram Alpha
        result = Wolfram.fetch(eq[1])

        # Get hash of results
        hash = Wolfram::HashPresenter.new(result).to_hash

        # Debug output hash
        puts hash
      
        # Breakdown hash
        pods = hash[:pods]

        # Try for results
        result = pods["Result"]
        puts result

        send_message client, _data.channel, hash

      end
    end
  end
end
