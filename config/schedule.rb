env :PATH, ENV["PATH"]
set :environment, "development"
set :output, {error: "log/whenever.log"}
every 15.minutes do
  rake "job:borrow_process"
end
every :day, at: "8:00am" do
  runner "NotifyMailer.send_expiring_borrow.deliver_now"
end
