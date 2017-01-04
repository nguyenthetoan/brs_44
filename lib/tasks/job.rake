namespace :job do
  desc "Process User Borrow Request Below"
  task borrow_process: :environment do
    ProcessBorrowWorker.perform_async
  end
end
