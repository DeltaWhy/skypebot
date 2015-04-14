#!/usr/bin/ruby
require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.hephaestos.me'
    c.nick = 'SkypeBot'
    c.channels = ['#main']
  end

  on :message do |m|
    puts "<#{m.user.nick}> #{m.message}"
    STDOUT.flush
  end
end

thr = Thread.new do
  loop do
    m = gets
    STDERR.puts m
    STDERR.flush
    bot.channels[0].send(m)
  end
end
bot.start
