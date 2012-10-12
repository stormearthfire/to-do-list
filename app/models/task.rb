class Task < ActiveRecord::Base
  before_save :default_values
  
  attr_accessible :description, :ordinal, :done, :user_id
  belongs_to :user
  
  default_scope order(:ordinal, :id)
  scope :newest, order('created_at desc')
  scope :undone, where(:done => false)
  scope :done, where(:done => true).order('updated_at desc')
  
  validates :description, :presence => true, :length => { :minimum => 3 }, :uniqueness => true
  
  def default_values
  	self.ordinal ||= 0
  	self.done = false if self.done.nil?
  	true
  end
  
  def self.order_tasks(ids)
    @tasks = Task.find(ids)
    @tasks.each do |task|
      task.ordinal = ids.index(task.id.to_s) + 1
      task.save
    end
  end
end
