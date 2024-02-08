class DeleteExpiredPostsJob
  include Sidekiq::Job

  def perform(*args)
    Post.where('created_at < ?', 24.hours.ago).destroy_all
  end
end
