require "capistrano/skype/version"
require "capistrano"

module Capistrano
  module Skype
    class SkypeInterface
      attr_accessor :target_chat_id

      SCRIPT_PATH = File.join(File.dirname(__FILE__), "../../applescripts/")

      def initialize(chat_topic)
        @target_chat_id = get_chat_id_for_topic(chat_topic)
      end

      def chats
        @chats ||= `osascript #{SCRIPT_PATH}chats.applescript`
      end

      def get_topic_for_chat(chat_id)
        `osascript #{SCRIPT_PATH}topic_for_chat.applescript '#{chat_id}'`
      end

      def get_chat_id_for_topic(target_topic = "dummy_stuff")
        found_chat_id = nil

        chats.gsub("CHATS ", "").split(",").each do |chat_id|
          details = (get_topic_for_chat chat_id).chomp.split("TOPIC ")
          puts details
          topic = details[1].chomp if details.size > 1
          found_chat_id = chat_id if topic == target_topic
        end

        found_chat_id
      end

      def send_message(message)
        `osascript #{SCRIPT_PATH}send_message.applescript '#{@target_chat_id}' '#{message}'`  unless target_chat_id.nil?
      end

    end
  end
end

namespace :deploy do
  desc 'Post an event to graphite'
  task :notify_skype, :action do |t, args|
    action = args[:action]
    on roles(:all) do
      SkypeInterface.new('DEV Chat Rails').send_message("Deploy #{action}")
    end
  end

  # after 'deploy:finished', 'deploy:notify_skype:finished'

  # after 'deploy:started', 'notify_skype_deploy' do
  #   Rake::Task['deploy:notify_skype'].invoke 'started'
  # end

end
