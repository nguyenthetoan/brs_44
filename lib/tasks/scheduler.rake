desc "This task is called by the Heroku scheduler add-on"
task borrow_process: :environment do
  puts "Processing all borrows...."
  ProcessBorrowWorker.perform_async
  puts "Finish proccessing."
end

