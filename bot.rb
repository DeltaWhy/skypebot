#!/usr/bin/ruby
require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.deltawhy.me'
    c.nick = 'SkypeBot'
    c.password = 'deltacraft'
    c.channels = ['#deltacraft']
    c.modes = ['+B']
  end

  on :message do |m|
    puts "<#{m.user.nick}> #{m.message}" unless m.action?
    STDOUT.flush
  end

  on :action do |m|
    puts "* #{m.user.nick} #{m.action_message}"
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
