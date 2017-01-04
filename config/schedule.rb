env :PATH, ENV["PATH"]
set :environment, "development"
set :output, {error: "log/whenever.log"}
every 15.minutes do
  rake "job:borrow_process"
  runner NotifyMailer.send_available_borrow.deliver_now
end
