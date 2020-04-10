class EventStat < ApplicationRecord
  belongs_to :event
  after_save :add_stats
  private
  def add_stats
    stat =self.ticket_type.event.event_stat
    stat.attendance+=1
    stat.tickets_sold+=1
    stat.save
  end

  after_destroy :delete_stats
  private
  def delete_stats
    stat =self.ticket_type.event.event_stat
    stat.attendance-=1
    stat.tickets_sold-=1
    stat.save
  end

  before_create :surpasses
  private
  def surpasses
    sold =self.ticket_type.event.event_stat.tickets_sold
    capacity =self.ticket_type.event.event_venue.capacity
    if capacity<sold
      puts "Tickets sold surpasses the capacity of the venue"
      throw :abort
    end
  end

end
