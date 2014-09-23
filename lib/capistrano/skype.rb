require "capistrano/skype/version"
require "capistrano"

module Capistrano
  module Skype
    class MacOSSkypeInterface
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
          topic = details[1].chomp if details.size > 1
          found_chat_id = chat_id if topic == target_topic
        end

        found_chat_id
      end

      def send_message(message)
        `osascript #{SCRIPT_PATH}send_message.applescript '#{@target_chat_id}' '#{message}'` unless target_chat_id.nil?
      end
    end
  end
end

namespace :deploy do
  namespace :skype do
    def send_message(message)
      if fetch(:skype_chat_name).to_s.empty?
        warn("Could not notify skype chat: please set `skype_chat_name`.")
      else
        Capistrano::Skype::MacOSSkypeInterface.new(fetch(:skype_chat_name)).send_message(message)
      end
    end

    desc 'Send deploy started'
    task :started do
      on roles(:all) do
        message = "[#{fetch(:application)}]" \
                  "(#{fetch(:stage).upcase})" \
                  " Deploy started"

        send_message(fetch(:started_notification) || message)
      end
    end

    desc 'Send deploy finished'
    task :finished do
      def commit_url(revision)
        if !fetch(:project_url).to_s.empty?
          "#{fetch(:project_url)}/commit/#{revision}"
        else
          "Revision #{revision}"
        end
      end

      on roles(:all) do
        message = "Finished deploy of " \
                  " #{commit_url(fetch(:current_revision))}" \
                  " (#{fetch(:branch)})"

        send_message(fetch(:finished_notification) || message)
      end
    end

    desc 'Send deploy rollback'
    task :rollback do
      on roles(:all) do
        message = "(doh) Deployment failed. Rolled back (doh)"
        send_message(fetch(:rollback_notification) || message)
      end
    end
  end

  after 'deploy:started',            'deploy:skype:started'
  after 'deploy:finished',           'deploy:skype:finished'
  after 'deploy:finishing_rollback', 'deploy:skype:rollback'
end
